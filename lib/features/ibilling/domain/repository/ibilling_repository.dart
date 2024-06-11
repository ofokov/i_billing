import 'package:dartz/dartz.dart';
import 'package:i_billing/features/ibilling/domain/enteties/contracts.dart';
import 'package:i_billing/features/ibilling/domain/enteties/user.dart';

import '../../../core/erorr/failure.dart';

abstract interface class IBillingRepository {
  Future<Either<Failures, List<Contract>>> getListOfContracts();
  Future<Either<Failures, User>> getUserInfo(String email);
  Future<Either<Failures, Contract>> getContract(String id);
  Future<Either<Failures, void>> createNewContract(Contract contract);
  Future<Either<Failures, void>> deleteContract(Contract contract);

  //new
  Future<Either<Failures, List<Contract>>> getLimitedListOfContract();
  Future<Either<Failures, List<Contract>>> getMoreListOfContract(
      List<Contract> contracts);
}
