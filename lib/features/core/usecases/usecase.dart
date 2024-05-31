import 'package:dartz/dartz.dart';

import '../erorr/failure.dart';

abstract interface class IBillingUseCase<Type, Param> {
  Future<Either<Failures, Type>> call(Param param);
}

class NoParams {}
