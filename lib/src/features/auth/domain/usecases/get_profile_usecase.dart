import 'package:dartz/dartz.dart';
import 'package:utueji/src/features/auth/domain/entities/user_entity.dart';
import 'package:utueji/src/features/auth/domain/repositories/auth_repository.dart';

class GetProfileUseCase {
  final AuthRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Exception, UserEntity>> call() {
    return repository.getProfile();
  }
}
