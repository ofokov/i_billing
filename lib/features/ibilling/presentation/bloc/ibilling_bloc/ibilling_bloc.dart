import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:i_billing/features/core/erorr/failure.dart';
import 'package:i_billing/features/ibilling/domain/usecases/create_contract_use_case.dart';
import 'package:i_billing/features/ibilling/domain/usecases/get_contract_use_case.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/contract_model.dart';
import '../../../domain/enteties/contracts.dart';
import '../../../domain/enteties/user.dart';
import '../../../domain/usecases/get_list_of_contacts_use_case.dart';
import '../../../domain/usecases/get_user_info_use_case.dart';
import '../connection_bloc/connection_bloc.dart';

part 'ibilling_event.dart';
part 'ibilling_state.dart';

const SERVER_FAILURE = 'SERVER_FAILURE';
const CONNECTION_FAILURE = 'CONNECTION_FAILURE';

class IbillingBloc extends Bloc<IbillingEvent, IbillingState> {
  final GetListOfContactsUseCase getListOfContractsUseCase;
  final CreateContractUseCase createContractUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final GetContractUseCase getContractUseCase;
  final NetworkBloc networkBloc;
  StreamSubscription? connectivitySubscription;

  IbillingBloc({
    required this.createContractUseCase,
    required this.getContractUseCase,
    required this.getUserInfoUseCase,
    required this.getListOfContractsUseCase,
    required this.networkBloc,
    this.connectivitySubscription,
  }) : super(Initial()) {
    on<GetUserInfo>((event, emit) async {
      emit(Loading());
      final result =
          await getUserInfoUseCase.repository.getUserInfo(event.email);
      emit(result.fold(
        (failure) => _mapFailureToErrorState(failure),
        (user) => LoadedUserInfo(user: user),
      ));
    });
    on<GetListOfContracts>((event, emit) async {
      emit(Loading());
      final result =
          await getListOfContractsUseCase.repository.getListOfContracts();
      emit(result.fold(
        (failure) => _mapFailureToErrorState(failure),
        (contracts) => LoadedListOfContracts(contracts: contracts),
      ));
    });
    on<GetSavedListOfContracts>((event, emit) async {
      emit(Loading());
      final result =
          await getListOfContractsUseCase.repository.getListOfContracts();
      emit(result.fold(
        (failure) => _mapFailureToErrorState(failure),
        (contracts) => LoadedSavedListOfContracts(
            contracts: contracts.where((c) => c.isSaved).toList()),
      ));
    });
    on<CreateContract>((event, emit) async {
      emit(Loading());
      final result = await createContractUseCase.repository
          .createNewContract(event.contract);
      emit(result.fold(
        (failure) => _mapFailureToErrorState(failure),
        (_) => const CreateSuccessfully(),
      ));
    });
    on<GetListOfContractInDateRange>((event, emit) async {
      emit(Loading());
      final result =
          await getListOfContractsUseCase.repository.getListOfContracts();
      emit(result.fold(
        (failure) => _mapFailureToErrorState(failure),
        (contracts) => LoadedDateRangeListOfContracts(
          contracts: contracts
              .where((c) =>
                  _isWithinDateRange(c.date, event.minDate, event.maxDate))
              .toList(),
        ),
      ));
    });
    on<GetListOfContractInDate>((event, emit) async {
      emit(Loading());
      final result =
          await getListOfContractsUseCase.repository.getListOfContracts();
      emit(result.fold(
        (failure) => _mapFailureToErrorState(failure),
        (contracts) => LoadedDateListOfContracts(
          contracts: contracts
              .where((c) => _isThisDate(c.date, event.dateTime))
              .toList(),
        ),
      ));
    });
    on<GetContractsByName>(
      (event, emit) async {
        emit(Loading());
        final result =
            await getListOfContractsUseCase.repository.getListOfContracts();
        emit(result.fold(
          (failure) => _mapFailureToErrorState(failure),
          (contracts) => LoadedSearchedListOfContracts(
            contracts: contracts
                .where((c) =>
                    c.fullName.toLowerCase().contains(event.name.toLowerCase()))
                .toList(),
          ),
        ));
      },
      transformer: debounceTransformer(const Duration(milliseconds: 300)),
    );

    on<GetFilteredListOfContract>((event, emit) async {
      emit(Loading());
      final result =
          await getListOfContractsUseCase.repository.getListOfContracts();
      emit(result.fold(
        (failure) => _mapFailureToErrorState(failure),
        (contracts) => LoadedFilteredListOfContracts(
          contracts: contracts.where((c) {
            print(c.contractState);
            print(event.states);
            return _isWithinDateRange(c.date, event.minDate, event.maxDate) &&
                event.states.contains(c.contractState);
          }).toList(),
        ),
      ));
    });

    on<GetContract>((event, emit) async {
      emit(Loading());
      final result = await getContractUseCase.repository.getContract(event.id);
      emit(result.fold(
        (failure) => _mapFailureToErrorState(failure),
        (contract) => LoadedContract(contract: contract),
      ));
    });

    on<ContractChangeSaveState>((event, emit) async {
      try {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        final Map<String, dynamic> jsonContract =
            (event.contract as ContractModel).toJson();

        print(event.isSaved.toString());
        print("=================== ${event.contract.id}");

        jsonContract['isSaved'] = event.isSaved;

        await firestore
            .collection('list_of_contracts')
            .doc(event.contract.id)
            .update(jsonContract);
      } catch (e) {
        print('Error: ${e.toString()}');
      }
    });
  }

  bool _isWithinDateRange(DateTime date, DateTime minDate, DateTime maxDate) {
    return (date.isAfter(minDate) || date.isAtSameMomentAs(minDate)) &&
        (date.isBefore(maxDate) || date.isAtSameMomentAs(maxDate));
  }

  bool _isThisDate(DateTime date, DateTime checkerDate) {
    return DateUtils.dateOnly(date)
        .isAtSameMomentAs(DateUtils.dateOnly(checkerDate));
  }

  IbillingState _mapFailureToErrorState(Failures failure) {
    return Erorr(
      message:
          (failure is ConnectionFailure) ? CONNECTION_FAILURE : SERVER_FAILURE,
    );
  }
}

EventTransformer<T> debounceTransformer<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
