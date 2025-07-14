import 'package:dartz/dartz.dart';
import 'package:utueji/src/features/auth/domain/entities/user_entity.dart';
import 'package:utueji/src/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Exception, UserEntity>> call(String name, String email, String password) {
    return repository.register(name, email, password);
  }
}
