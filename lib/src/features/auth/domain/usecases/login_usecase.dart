import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../params/login_params.dart';
import '../repositories/i_auth_repository.dart';

class LoginUseCase extends BaseUseCase<String, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    return repository.login(params);
  }
}
