import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_billing/features/core/erorr/exception.dart';
import 'package:i_billing/features/core/erorr/failure.dart';
import 'package:i_billing/features/ibilling/domain/usecases/create_contract_use_case.dart';

import '../../../domain/enteties/contracts.dart';
import '../../../domain/enteties/user.dart';
import '../../../domain/usecases/get_list_of_contacts_use_case.dart';
import '../../../domain/usecases/get_user_info_use_case.dart';
import '../connection_bloc/connection_bloc.dart';
import '../connection_bloc/connection_state.dart';

part 'ibilling_event.dart';
part 'ibilling_state.dart';

const SERVER_FAILURE = 'SERVER_FAILURE';
const CONNECTION_FAILURE = 'CONNECTION_FAILURE';

class IbillingBloc extends Bloc<IbillingEvent, IbillingState> {
  final GetListOfContactsUseCase getListOfContactsUseCase;
  final CreateContractUseCase createContract;
  final GetUserInfoUseCase getUserInfoUseCase;
  final NetworkBloc networkBloc;
  StreamSubscription? connectivitySubscription;

  IbillingBloc({
    required this.createContract,
    required this.getUserInfoUseCase,
    required this.getListOfContactsUseCase,
    required this.networkBloc,
    this.connectivitySubscription,
  }) : super(Initial()) {
    on<GetUserInfo>(
      (event, emit) async {
        emit(Loading());
        try {
          final result =
              await getUserInfoUseCase.repository.getUserInfo(event.email);
          emit(
            result.fold(
              (failure) {
                return Erorr(
                    message: (failure is ConnectionFailure)
                        ? CONNECTION_FAILURE
                        : SERVER_FAILURE);
              },
              (user) {
                return LoadedUserInfo(user: user);
              },
            ),
          );
        } on ServerException {
          emit(const Erorr(message: (SERVER_FAILURE)));
        }
        connectivitySubscription =
            networkBloc.stream.listen((connectivityState) {
          if (connectivityState is NetworkSuccess) {
            add(GetUserInfo(event.email));
          }
        });
      },
    );
    on<GetListOfContracts>((event, emit) async {
      emit(Loading());
      try {
        final result =
            await getListOfContactsUseCase.repository.getListOfContracts();
        emit(
          result.fold(
            (failure) {
              return Erorr(
                  message: (failure is ConnectionFailure)
                      ? CONNECTION_FAILURE
                      : SERVER_FAILURE);
            },
            (contracts) {
              return LoadedListOfContracts(contracts: contracts);
            },
          ),
        );
      } on ServerException {
        emit(const Erorr(message: (SERVER_FAILURE)));
      }
      connectivitySubscription = networkBloc.stream.listen((connectivityState) {
        if (connectivityState is NetworkSuccess) {
          add(const GetListOfContracts());
        }
      });
    });
    on<GetSavedListOfContracts>((event, emit) async {
      emit(Loading());
      try {
        final result =
            await getListOfContactsUseCase.repository.getListOfContracts();
        emit(
          result.fold(
            (failure) {
              return Erorr(
                  message: (failure is ConnectionFailure)
                      ? CONNECTION_FAILURE
                      : SERVER_FAILURE);
            },
            (contracts) {
              List<Contract> result =
                  contracts.where((a) => a.isSaved).toList();
              return LoadedSavedListOfContracts(contracts: result);
            },
          ),
        );
      } on ServerException {
        emit(const Erorr(message: (SERVER_FAILURE)));
      }
      connectivitySubscription = networkBloc.stream.listen((connectivityState) {
        if (connectivityState is NetworkSuccess) {
          add(const GetListOfContracts());
        }
      });
    });
    on<CreateContract>((event, emit) async {
      emit(Loading());
      try {
        final result =
            await createContract.repository.createNewContract(event.contract);
        emit(
          result.fold(
            (failure) {
              return Erorr(
                  message: (failure is ConnectionFailure)
                      ? CONNECTION_FAILURE
                      : SERVER_FAILURE);
            },
            (_) {
              return const CreateSuccessfully();
            },
          ),
        );
      } on ServerException {
        emit(const Erorr(message: (SERVER_FAILURE)));
      }
      connectivitySubscription = networkBloc.stream.listen((connectivityState) {
        if (connectivityState is NetworkSuccess) {
          add(CreateContract(event.contract));
        }
      });
    });
    on<GetListOfContractInDateRange>((event, emit) async {
      emit(Loading());
      try {
        final result =
            await getListOfContactsUseCase.repository.getListOfContracts();
        emit(
          result.fold(
            (failure) {
              return Erorr(
                  message: (failure is ConnectionFailure)
                      ? CONNECTION_FAILURE
                      : SERVER_FAILURE);
            },
            (contracts) {
              List<Contract> result = contracts.where((a) {
                bool isInRange = a.date.isAfter(event.minDate) &&
                    a.date.isBefore(event.maxDate);
                return isInRange;
              }).toList();
              return LoadedListOfContractInDateRange(contracts: result);
            },
          ),
        );
      } on ServerException {
        emit(const Erorr(message: (SERVER_FAILURE)));
      }
      connectivitySubscription = networkBloc.stream.listen((connectivityState) {
        if (connectivityState is NetworkSuccess) {
          add(const GetListOfContracts());
        }
      });
    });
  }
}
