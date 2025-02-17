import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/i_auth_repository.dart';

class SignOutUseCase {
  final IAuthRepository repository;
  SignOutUseCase({required this.repository});

  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
}
