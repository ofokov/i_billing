import 'package:dartz/dartz.dart';
import 'package:i_billing/features/ibilling/domain/enteties/contracts.dart';
import 'package:i_billing/features/ibilling/domain/enteties/user.dart';

import '../../../core/erorr/failure.dart';

abstract interface class IBillingRepository {
  Future<Either<Failures, List<Contract>>> getListOfContracts();
  Future<Either<Failures, User>> getUserInfo(String email);
  Future<Either<Failures, void>> createNewContract(Contract contract);
}
