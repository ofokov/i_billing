part of 'ibilling_bloc.dart';

sealed class IbillingEvent extends Equatable {
  const IbillingEvent();
}

class GetUserInfo extends IbillingEvent {
  final String email;

  const GetUserInfo(this.email);

  @override
  List<Object?> get props => [email];
}

class GetListOfContracts extends IbillingEvent {
  const GetListOfContracts();

  @override
  List<Object?> get props => [];
}

class GetLimitedListOfContracts extends IbillingEvent {
  const GetLimitedListOfContracts();

  @override
  List<Object?> get props => [];
}

class GetMoreListOfContracts extends IbillingEvent {
  final List<Contract> contracts;
  const GetMoreListOfContracts(this.contracts);

  @override
  List<Object?> get props => [];
}

class GetListOfContractInDateRange extends IbillingEvent {
  final DateTime minDate;
  final DateTime maxDate;

  const GetListOfContractInDateRange({
    required this.minDate,
    required this.maxDate,
  });

  @override
  List<Object?> get props => [];
}

class GetListOfContractInDate extends IbillingEvent {
  final DateTime dateTime;

  const GetListOfContractInDate({
    required this.dateTime,
  });

  @override
  List<Object?> get props => [];
}

class GetFilteredListOfContract extends IbillingEvent {
  final DateTime minDate;
  final DateTime maxDate;
  final List<String> states;

  const GetFilteredListOfContract({
    required this.minDate,
    required this.states,
    required this.maxDate,
  });

  @override
  List<Object?> get props => [];
}

class GetContractsByName extends IbillingEvent {
  final String name;
  const GetContractsByName({required this.name});

  @override
  List<Object?> get props => [];
}

class ContractChangeSaveState extends IbillingEvent {
  final Contract contract;
  final bool isSaved;
  const ContractChangeSaveState({
    required this.contract,
    required this.isSaved,
  });

  @override
  List<Object?> get props => [contract, isSaved];
}

class GetContract extends IbillingEvent {
  final String id;
  const GetContract({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

class GetSavedListOfContracts extends IbillingEvent {
  const GetSavedListOfContracts();

  @override
  List<Object?> get props => [];
}

class CreateContract extends IbillingEvent {
  final Contract contract;

  const CreateContract(this.contract);

  @override
  List<Object?> get props => [contract];
}
