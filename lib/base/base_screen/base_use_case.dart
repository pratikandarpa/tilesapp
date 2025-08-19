import 'package:dartz/dartz.dart';

import '../../utils/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Type, Failure>> call(Params params);
}

abstract class NoParamsUseCase<Type> {
  Future<Either<Type, Failure>> call();
}

abstract class UseCaseGeneric<Type, T> {
  Future<Either<Type, Failure>> call(T params);
}
