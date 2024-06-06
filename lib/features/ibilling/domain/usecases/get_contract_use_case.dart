import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:i_billing/features/ibilling/domain/enteties/contracts.dart';

import '../../../core/erorr/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../repository/ibilling_repository.dart';

class GetContractUseCase implements IBillingUseCase<Contract, Param> {
  final IBillingRepository repository;

  GetContractUseCase({required this.repository});

  @override
  Future<Either<Failures, Contract>> call(Param params) async {
    return await repository.getContract(params.id);
  }
}

class Param extends Equatable {
  final String id;

  const Param({required this.id});

  @override
  List<Object?> get props => [id];
}
