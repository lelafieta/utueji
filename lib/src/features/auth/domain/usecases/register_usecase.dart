import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/i_auth_repository.dart';

class RegisterUseCase {
  final IAuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, String>> call(RegisterParams params) {
    return repository.register(params);
  }
}
