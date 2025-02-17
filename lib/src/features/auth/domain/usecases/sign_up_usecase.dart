import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

class SignUpUseCase {
  final IAuthRepository repository;
  SignUpUseCase({required this.repository});

  Future<Either<Failure, UserEntity?>> call(
      String email, String password) async {
    return await repository.signUp(email, password);
  }
}
