import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/i_auth_repository.dart';

class IsSignInUseCase {
  final IAuthRepository repository;
  IsSignInUseCase({required this.repository});

  Future<Either<Failure, bool>> call() async {
    return await repository.isSignedIn();
  }
}
