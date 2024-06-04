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
