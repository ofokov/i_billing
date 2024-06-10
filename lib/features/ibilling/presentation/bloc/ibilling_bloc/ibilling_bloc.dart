import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:i_billing/features/ibilling/domain/usecases/create_contract_use_case.dart';
import 'package:i_billing/features/ibilling/domain/usecases/get_contract_use_case.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/interner_bloc/internet_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/constants/formz_submission_status.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/contract_model.dart';
import '../../../domain/enteties/contracts.dart';
import '../../../domain/enteties/user.dart';
import '../../../domain/usecases/get_list_of_contacts_use_case.dart';
import '../../../domain/usecases/get_user_info_use_case.dart';

part 'ibilling_event.dart';
part 'ibilling_state.dart';

const SERVER_FAILURE = 'SERVER_FAILURE';
const CONNECTION_FAILURE = 'CONNECTION_FAILURE';

class IbillingBloc extends Bloc<IbillingEvent, IbillingState> {
  final GetListOfContactsUseCase getListOfContractsUseCase;
  final CreateContractUseCase createContractUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final GetContractUseCase getContractUseCase;
  final InternetBloc internetBloc;
  StreamSubscription? connectivitySubscription;

  IbillingBloc({
    required this.createContractUseCase,
    required this.internetBloc,
    required this.getContractUseCase,
    required this.getUserInfoUseCase,
    required this.getListOfContractsUseCase,
    this.connectivitySubscription,
  }) : super(const IbillingState()) {
    on<GetUserInfo>((event, emit) async {
      emit(state.copyWith(userInfoStatus: FormzSubmissionStatus.inProgress));
      final result =
          await getUserInfoUseCase.repository.getUserInfo(event.email);
      emit(result.fold(
        (failure) =>
            state.copyWith(userInfoStatus: FormzSubmissionStatus.failure),
        (user) => state.copyWith(
          userInfoStatus: FormzSubmissionStatus.success,
          userInfo: user,
        ),
      ));
      print(state);
    });
    on<GetListOfContracts>((event, emit) async {
      emit(state.copyWith(allStatus: FormzSubmissionStatus.inProgress));
      final result =
          await getListOfContractsUseCase.repository.getListOfContracts();
      emit(result.fold(
        (failure) => state.copyWith(allStatus: FormzSubmissionStatus.failure),
        (contracts) => state.copyWith(
          allStatus: FormzSubmissionStatus.success,
          allContracts: contracts,
        ),
      ));
      print(state);
    });
    on<GetMoreListOfContracts>((event, emit) async {
      emit(state.copyWith(moreStatus: FormzSubmissionStatus.inProgress));
      final result = await getListOfContractsUseCase.repository
          .getMoreListOfContract(event.contracts);
      emit(result.fold(
        (failure) => state.copyWith(moreStatus: FormzSubmissionStatus.failure),
        (contracts) => state.copyWith(
            moreStatus: FormzSubmissionStatus.success,
            moreContracts: contracts),
      ));
      print(state);
    });
    on<GetLimitedListOfContracts>((event, emit) async {
      emit(state.copyWith(limitedStatus: FormzSubmissionStatus.inProgress));
      final result =
          await getListOfContractsUseCase.repository.getLimitedListOfContract();
      emit(result.fold(
        (failure) =>
            state.copyWith(limitedStatus: FormzSubmissionStatus.failure),
        (contracts) => state.copyWith(
          limitedStatus: FormzSubmissionStatus.success,
          limitedContracts: contracts,
        ),
      ));
      print(state);
    });
    on<GetSavedListOfContracts>((event, emit) async {
      emit(state.copyWith(savedStatus: FormzSubmissionStatus.inProgress));
      final result =
          await getListOfContractsUseCase.repository.getListOfContracts();
      emit(result.fold(
        (failure) => state.copyWith(savedStatus: FormzSubmissionStatus.failure),
        (contracts) => state.copyWith(
          savedStatus: FormzSubmissionStatus.success,
          savedContracts: contracts.where((c) => c.isSaved).toList(),
        ),
      ));
      print(state);
    });
    on<CreateContract>((event, emit) async {
      emit(state.copyWith(
          createContractStatus: FormzSubmissionStatus.inProgress));
      final result = await createContractUseCase.repository
          .createNewContract(event.contract);
      emit(result.fold(
        (failure) =>
            state.copyWith(createContractStatus: FormzSubmissionStatus.failure),
        (_) =>
            state.copyWith(createContractStatus: FormzSubmissionStatus.success),
      ));
      print(state);
    });
    on<GetListOfContractInDateRange>((event, emit) async {
      emit(state.copyWith(inDateRangeStatus: FormzSubmissionStatus.inProgress));
      final result =
          await getListOfContractsUseCase.repository.getListOfContracts();
      emit(result.fold(
        (failure) =>
            state.copyWith(inDateRangeStatus: FormzSubmissionStatus.failure),
        (contracts) => state.copyWith(
            inDateRangeStatus: FormzSubmissionStatus.success,
            inDateRangeContracts: contracts
                .where((c) =>
                    _isWithinDateRange(c.date, event.minDate, event.maxDate))
                .toList()),
      ));
      print(state);
    });
    on<GetListOfContractInDate>((event, emit) async {
      emit(state.copyWith(inSpecificStatus: FormzSubmissionStatus.inProgress));
      final result =
          await getListOfContractsUseCase.repository.getListOfContracts();
      emit(
        result.fold(
          (failure) =>
              state.copyWith(inSpecificStatus: FormzSubmissionStatus.failure),
          (contracts) => state.copyWith(
              inSpecificStatus: FormzSubmissionStatus.success,
              inSpecificDateContract: contracts
                  .where((c) => _isThisDate(c.date, event.dateTime))
                  .toList()),
        ),
      );
      print(state);
    });
    on<GetContractsByName>(
      (event, emit) async {
        emit(state.copyWith(searchedStatus: FormzSubmissionStatus.inProgress));
        final result =
            await getListOfContractsUseCase.repository.getListOfContracts();
        emit(result.fold(
          (failure) =>
              state.copyWith(searchedStatus: FormzSubmissionStatus.failure),
          (contracts) => state.copyWith(
              searchedStatus: FormzSubmissionStatus.success,
              searchedContracts: contracts
                  .where((c) => c.fullName
                      .toLowerCase()
                      .contains(event.name.toLowerCase()))
                  .toList()),
        ));
        print(state);
      },
      transformer: debounceTransformer(const Duration(milliseconds: 300)),
    );

    on<GetFilteredListOfContract>((event, emit) async {
      emit(state.copyWith(filterStatus: FormzSubmissionStatus.inProgress));
      final result =
          await getListOfContractsUseCase.repository.getListOfContracts();
      emit(result.fold(
        (failure) =>
            state.copyWith(filterStatus: FormzSubmissionStatus.failure),
        (contracts) => state.copyWith(
            filterStatus: FormzSubmissionStatus.success,
            filteredContracts: contracts.where((c) {
              return _isWithinDateRange(c.date, event.minDate, event.maxDate) &&
                  event.states.contains(c.contractState);
            }).toList()),
      ));
      print(state);
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
    print(state);
  }

  bool _isWithinDateRange(DateTime date, DateTime minDate, DateTime maxDate) {
    return (date.isAfter(minDate) || date.isAtSameMomentAs(minDate)) &&
        (date.isBefore(maxDate) || date.isAtSameMomentAs(maxDate));
  }

  bool _isThisDate(DateTime date, DateTime checkerDate) {
    return DateUtils.dateOnly(date)
        .isAtSameMomentAs(DateUtils.dateOnly(checkerDate));
  }
}

EventTransformer<T> debounceTransformer<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
