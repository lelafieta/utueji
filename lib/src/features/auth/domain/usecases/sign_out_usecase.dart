import 'package:dartz/dartz.dart';
import 'package:utueji/src/core/entities/no_params.dart';
import 'package:utueji/src/core/usecases/base_usecase.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/i_auth_repository.dart';

class SignOutUseCase extends BaseUseCase<Unit, NoParams> {
  final IAuthRepository repository;
  SignOutUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(NoParams noParams) async {
    return await repository.signOut();
  }
}
