part of 'ibilling_bloc.dart';

class IbillingState extends Equatable {
  final int? filteredPageIndex;
  final List<Contract> filteredContracts;
  final List<Contract> savedContracts;
  final List<Contract> searchedContracts;
  final List<Contract> inSpecificDateContract;
  final List<Contract> inDateRangeContracts;
  final List<Contract> moreContracts;
  final User? userInfo;
  final FormzSubmissionStatus filterStatus;
  final FormzSubmissionStatus savedStatus;
  final FormzSubmissionStatus searchedStatus;
  final FormzSubmissionStatus inSpecificStatus;
  final FormzSubmissionStatus inDateRangeStatus;
  final FormzSubmissionStatus userInfoStatus;
  final FormzSubmissionStatus moreStatus;
  final FormzSubmissionStatus createContractStatus;
  final FormzSubmissionStatus deleteContractStatus;

  const IbillingState({
    this.filteredPageIndex,
    this.filteredContracts = const [],
    this.savedContracts = const [],
    this.searchedContracts = const [],
    this.inSpecificDateContract = const [],
    this.inDateRangeContracts = const [],
    this.moreContracts = const [],
    this.userInfo,
    this.filterStatus = FormzSubmissionStatus.initial,
    this.savedStatus = FormzSubmissionStatus.initial,
    this.searchedStatus = FormzSubmissionStatus.initial,
    this.inSpecificStatus = FormzSubmissionStatus.initial,
    this.inDateRangeStatus = FormzSubmissionStatus.initial,
    this.userInfoStatus = FormzSubmissionStatus.initial,
    this.moreStatus = FormzSubmissionStatus.initial,
    this.createContractStatus = FormzSubmissionStatus.initial,
    this.deleteContractStatus = FormzSubmissionStatus.initial,
  });

  IbillingState copyWith({
    int? filteredPageIndex,
    List<Contract>? filteredContracts,
    List<Contract>? savedContracts,
    List<Contract>? searchedContracts,
    List<Contract>? inSpecificDateContract,
    List<Contract>? inDateRangeContracts,
    List<Contract>? moreContracts,
    List<Contract>? limitedContracts,
    User? userInfo,
    FormzSubmissionStatus? filterStatus,
    FormzSubmissionStatus? savedStatus,
    FormzSubmissionStatus? searchedStatus,
    FormzSubmissionStatus? inSpecificStatus,
    FormzSubmissionStatus? inDateRangeStatus,
    FormzSubmissionStatus? userInfoStatus,
    FormzSubmissionStatus? moreStatus,
    FormzSubmissionStatus? limitedStatus,
    FormzSubmissionStatus? createContractStatus,
    FormzSubmissionStatus? deleteContractStatus,
  }) {
    return IbillingState(
      filteredPageIndex: filteredPageIndex ?? this.filteredPageIndex,
      filteredContracts: filteredContracts ?? this.filteredContracts,
      savedContracts: savedContracts ?? this.savedContracts,
      searchedContracts: searchedContracts ?? this.searchedContracts,
      inSpecificDateContract:
          inSpecificDateContract ?? this.inSpecificDateContract,
      inDateRangeContracts: inDateRangeContracts ?? this.inDateRangeContracts,
      moreContracts: moreContracts ?? this.moreContracts,
      userInfo: userInfo ?? this.userInfo,
      filterStatus: filterStatus ?? this.filterStatus,
      savedStatus: savedStatus ?? this.savedStatus,
      searchedStatus: searchedStatus ?? this.searchedStatus,
      inSpecificStatus: inSpecificStatus ?? this.inSpecificStatus,
      inDateRangeStatus: inDateRangeStatus ?? this.inDateRangeStatus,
      userInfoStatus: userInfoStatus ?? this.userInfoStatus,
      moreStatus: moreStatus ?? this.moreStatus,
      createContractStatus: createContractStatus ?? this.createContractStatus,
      deleteContractStatus: deleteContractStatus ?? this.deleteContractStatus,
    );
  }

  @override
  String toString() {
    return '''IbillingState {
      filteredPageIndex: $filteredPageIndex
      filteredContracts: $filteredContracts,
      savedContracts: $savedContracts,
      searchedContracts: $searchedContracts,
      inSpecificDateContract: $inSpecificDateContract,
      inDateRangeContracts: $inDateRangeContracts,
      moreContracts: $moreContracts,
      userInfo: $userInfo,
      filterStatus: $filterStatus,
      savedStatus: $savedStatus,
      searchedStatus: $searchedStatus,
      inSpecificStatus: $inSpecificStatus,
      inDateRangeStatus: $inDateRangeStatus,
      userInfoStatus: $userInfoStatus,
      moreStatus: $moreStatus,
      createContractStatus: $createContractStatus,
      deleteContractStatus: $deleteContractStatus,
    }''';
  }

  @override
  List<Object?> get props => [
        filteredPageIndex,
        filteredContracts,
        savedContracts,
        searchedContracts,
        inSpecificDateContract,
        inDateRangeContracts,
        moreContracts,
        userInfo,
        filterStatus,
        savedStatus,
        searchedStatus,
        inSpecificStatus,
        inDateRangeStatus,
        userInfoStatus,
        moreStatus,
        createContractStatus,
        deleteContractStatus,
      ];
}
