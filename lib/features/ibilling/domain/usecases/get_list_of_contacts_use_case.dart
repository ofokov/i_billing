import 'package:dartz/dartz.dart';
import 'package:i_billing/features/ibilling/domain/repository/ibilling_repository.dart';

import '../../../core/erorr/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../enteties/contracts.dart';

class GetListOfContactsUseCase
    implements IBillingUseCase<List<Contract>, NoParams> {
  final IBillingRepository repository;

  GetListOfContactsUseCase({required this.repository});

  @override
  Future<Either<Failures, List<Contract>>> call(NoParams noParams) async {
    return await repository.getListOfContracts();
  }
}
