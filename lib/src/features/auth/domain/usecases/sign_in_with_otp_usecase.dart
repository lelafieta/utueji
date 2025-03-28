import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/login_parameters.dart';
import '../repositories/i_auth_repository.dart';

class SignInWithOtpUseCase extends BaseUseCase<Unit, LoginParameters> {
  final IAuthRepository repository;
  SignInWithOtpUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(LoginParameters params) async {
    return await repository.signInWithOtp(params.phone!);
  }
}
