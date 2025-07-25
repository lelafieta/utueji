import 'package:dartz/dartz.dart';
import 'package:utueji/src/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({Params params});
}
