import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/login_parameters.dart';
import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

class SignInUseCase extends BaseUseCase<UserEntity?, LoginParameters> {
  final IAuthRepository repository;
  SignInUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity?>> call(LoginParameters params) async {
    return await repository.signIn(
        email: params.email!, password: params.password!);
  }
}
