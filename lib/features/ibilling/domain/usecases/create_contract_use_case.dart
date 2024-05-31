import 'package:dartz/dartz.dart';
import 'package:i_billing/features/core/erorr/failure.dart';
import 'package:i_billing/features/ibilling/domain/repository/ibilling_repository.dart';

import '../../../core/usecases/usecase.dart';
import '../enteties/contracts.dart';

class CreateContractUseCase implements IBillingUseCase<void, Contract> {
  final IBillingRepository repository;

  CreateContractUseCase({required this.repository});
  @override
  Future<Either<Failures, void>> call(Contract contract) async {
    return await repository.createNewContract(contract);
  }
}
