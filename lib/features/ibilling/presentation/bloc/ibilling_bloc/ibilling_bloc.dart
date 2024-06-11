import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:i_billing/features/ibilling/domain/usecases/create_contract_use_case.dart';
import 'package:i_billing/features/ibilling/domain/usecases/delete_contract_use_case.dart';
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
  final DeleteContractUseCase deleteContractUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final GetContractUseCase getContractUseCase;
  final InternetBloc internetBloc;
  StreamSubscription? connectivitySubscription;

  IbillingBloc({
    required this.createContractUseCase,
    required this.deleteContractUseCase,
    required this.internetBloc,
    required this.getContractUseCase,
    required this.getUserInfoUseCase,
    required this.getListOfContractsUseCase,
    this.connectivitySubscription,
  }) : super(const IbillingState()) {
    on<GetUserInfo>((event, emit) async {
      emit(state.copyWith(
        userInfoStatus: FormzSubmissionStatus.inProgress,
        filterStatus: FormzSubmissionStatus.initial,
      ));
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
    on<GetMoreListOfContracts>((event, emit) async {
      emit(state.copyWith(
          moreStatus: FormzSubmissionStatus.inProgress,
          filterStatus: FormzSubmissionStatus.initial));
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
    on<GetSavedListOfContracts>((event, emit) async {
      emit(state.copyWith(
          savedStatus: FormzSubmissionStatus.inProgress,
          filterStatus: FormzSubmissionStatus.initial));
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
    on<DeleteContract>((event, emit) async {
      emit(state.copyWith(
          createContractStatus: FormzSubmissionStatus.inProgress,
          filterStatus: FormzSubmissionStatus.initial));
      final result =
          await deleteContractUseCase.repository.deleteContract(event.contract);
      emit(result.fold(
        (failure) =>
            state.copyWith(createContractStatus: FormzSubmissionStatus.failure),
        (_) =>
            state.copyWith(createContractStatus: FormzSubmissionStatus.success),
      ));
      print(state);
    });
    on<GetListOfContractInDateRange>((event, emit) async {
      emit(state.copyWith(
          inDateRangeStatus: FormzSubmissionStatus.inProgress,
          filterStatus: FormzSubmissionStatus.initial));
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
      emit(state.copyWith(
          inSpecificStatus: FormzSubmissionStatus.inProgress,
          filterStatus: FormzSubmissionStatus.initial));
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
      final List<Contract> result;
      switch (state.filteredPageIndex) {
        case 0:
          result = state.inSpecificDateContract;
          break;
        case 1:
          result = state.inDateRangeContracts;
          break;
        case 3:
          result = state.savedContracts;
          break;
        default:
          result = [];
      }
      emit(
        state.copyWith(
          filteredPageIndex: event.filteredPage,
          filterStatus: FormzSubmissionStatus.success,
          filteredContracts: result.where(
            (c) {
              return _isWithinDateRange(c.date, event.minDate, event.maxDate) &&
                  event.states.contains(c.contractState);
            },
          ).toList(),
        ),
      );
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
