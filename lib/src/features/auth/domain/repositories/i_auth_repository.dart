import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';
import '../params/login_params.dart';
import '../params/register_params.dart';

abstract class IAuthRepository {
  Future<Either<Failure, String>> register(RegisterParams params);
  Future<Either<Failure, String>> login(LoginParams params);
  Future<Either<Failure, UserEntity>> getProfile();
}
