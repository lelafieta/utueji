import 'package:dartz/dartz.dart';

import '../../../../core/entities/no_params.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../repositories/i_auth_repository.dart';

class IsSignInUseCase extends BaseUseCase<bool, NoParams> {
  final IAuthRepository repository;
  IsSignInUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isSignedIn();
  }
}
