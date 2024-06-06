part of 'ibilling_bloc.dart';

sealed class IbillingState extends Equatable {
  const IbillingState();
}

final class Initial extends IbillingState {
  @override
  List<Object> get props => [];
}

final class Loading extends IbillingState {
  @override
  List<Object> get props => [];
}

final class LoadedUserInfo extends IbillingState {
  final User user;

  const LoadedUserInfo({required this.user});

  @override
  List<Object> get props => [user];
}

final class LoadedContract extends IbillingState {
  final Contract contract;

  const LoadedContract({required this.contract});

  @override
  List<Object> get props => [contract];
}

final class CreateSuccessfully extends IbillingState {
  const CreateSuccessfully();

  @override
  List<Object> get props => [];
}

final class LoadedListOfContracts extends IbillingState {
  final List<Contract> contracts;

  const LoadedListOfContracts({required this.contracts});

  @override
  List<Object> get props => [contracts];
}

final class LoadedSavedListOfContracts extends IbillingState {
  final List<Contract> contracts;

  const LoadedSavedListOfContracts({required this.contracts});

  @override
  List<Object> get props => [contracts];
}

final class LoadedDateRangeListOfContracts extends IbillingState {
  final List<Contract> contracts;

  const LoadedDateRangeListOfContracts({required this.contracts});

  @override
  List<Object> get props => [contracts];
}

final class LoadedDateListOfContracts extends IbillingState {
  final List<Contract> contracts;

  const LoadedDateListOfContracts({required this.contracts});

  @override
  List<Object> get props => [contracts];
}

final class LoadedSearchedListOfContracts extends IbillingState {
  final List<Contract> contracts;

  const LoadedSearchedListOfContracts({required this.contracts});

  @override
  List<Object> get props => [contracts];
}

final class LoadedFilteredListOfContracts extends IbillingState {
  final List<Contract> contracts;

  const LoadedFilteredListOfContracts({required this.contracts});

  @override
  List<Object> get props => [contracts];
}

class Erorr extends IbillingState {
  final String message;

  const Erorr({required this.message});

  @override
  List<Object> get props => [message];
}
