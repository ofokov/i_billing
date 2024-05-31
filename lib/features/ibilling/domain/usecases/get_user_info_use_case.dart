import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/erorr/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../enteties/user.dart';
import '../repository/ibilling_repository.dart';

class GetUserInfoUseCase implements IBillingUseCase<User, Param> {
  final IBillingRepository repository;

  GetUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failures, User>> call(Param params) async {
    return await repository.getUserInfo(params.email);
  }
}

class Param extends Equatable {
  final String email;

  const Param({required this.email});

  @override
  List<Object?> get props => [email];
}
