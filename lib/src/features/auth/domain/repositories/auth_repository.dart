import 'package:dartz/dartz.dart';
import 'package:utueji/src/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Exception, UserEntity>> register(String name, String email, String password);
  Future<Either<Exception, UserEntity>> login(String email, String password);
  Future<Either<Exception, UserEntity>> getProfile();
}
