import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../params/register_params.dart';
import '../repositories/i_auth_repository.dart';

class RegisterUseCase extends BaseUseCase<String, RegisterParams>{
  final IAuthRepository repository;

  RegisterUseCase({required this.repository});

  
  @override
  Future<Either<Failure, String>> call(RegisterParams params) {
    return repository.register(params);
  }
}
