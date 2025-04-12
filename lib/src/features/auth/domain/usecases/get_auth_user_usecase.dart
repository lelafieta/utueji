import 'package:dartz/dartz.dart';

import '../../../../core/entities/no_params.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

class GetAuthUserUseCase extends BaseUseCase<UserEntity, NoParams> {
  final IAuthRepository repository;

  GetAuthUserUseCase({required this.repository});
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.authUser();
  }
}
