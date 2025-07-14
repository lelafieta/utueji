import 'package:dartz/dartz.dart';
import 'package:utueji/src/core/errors/server_failure.dart';
import 'package:utueji/src/features/auth/data/dto/create_auth_dto.dart';
import 'package:utueji/src/features/auth/data/dto/login_auth_dto.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/i_network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/params/login_params.dart';
import '../../domain/params/register_params.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepository implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final INetWorkInfo networkInfo;

  AuthRepository({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, String>> login(LoginParams params) async {
    try {
      final accessToken = await remoteDataSource.login(
        LoginAuthDto(email: params.email, password: params.password),
      );
      return Right(accessToken);
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> register(RegisterParams params) async {
    try {
      final accessToken = await remoteDataSource.register(
        CreateAuthDto(
          name: params.name,
          email: params.email,
          password: params.password,
          phone: params.phone,
        ),
      );
      return Right(accessToken);
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      final user = await remoteDataSource.getProfile();
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }
}
