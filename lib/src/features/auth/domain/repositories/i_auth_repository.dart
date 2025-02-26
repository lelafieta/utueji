import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class IAuthRepository {
  Future<Either<Failure, UserEntity>> signIn(
      {required String email, required String password});
  Future<Either<Failure, UserEntity>> signUp(String email, String password);
  Future<Either<Failure, Unit>> signOut();
  Future<Either<Failure, bool>> isSignedIn();
}
