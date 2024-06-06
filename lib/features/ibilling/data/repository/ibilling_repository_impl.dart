import 'package:dartz/dartz.dart';
import 'package:i_billing/features/core/erorr/exception.dart';
import 'package:i_billing/features/core/erorr/failure.dart';
import 'package:i_billing/features/ibilling/data/datasources/ibilling_remote_data_sources.dart';
import 'package:i_billing/features/ibilling/domain/enteties/contracts.dart';
import 'package:i_billing/features/ibilling/domain/enteties/user.dart';
import 'package:i_billing/features/ibilling/domain/repository/ibilling_repository.dart';

class IBillingRepositoryImpl implements IBillingRepository {
  final IbillingRemoteDataSources ibillingRemoteDataSources;
  IBillingRepositoryImpl({
    required this.ibillingRemoteDataSources,
  });

  @override
  Future<Either<Failures, List<Contract>>> getListOfContracts() async {
    try {
      return Right(await ibillingRemoteDataSources.getListContracts());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, User>> getUserInfo(String email) async {
    try {
      return Right(await ibillingRemoteDataSources.getUserInfo(email));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, void>> createNewContract(Contract contract) async {
    try {
      return Right(await ibillingRemoteDataSources.createNewContract(contract));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, Contract>> getContract(String id) async {
    try {
      return Right(await ibillingRemoteDataSources.getContract(id));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
