import 'package:dartz/dartz.dart';
import 'package:utueji/src/features/auth/domain/entities/user_entity.dart';
import 'package:utueji/src/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Exception, UserEntity>> call(String email, String password) {
    return repository.login(email, password);
  }
}
