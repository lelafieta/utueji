import 'package:dartz/dartz.dart';
import 'package:utueji/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:utueji/src/features/auth/domain/entities/user_entity.dart';
import 'package:utueji/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, UserEntity>> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);
      return Right(user);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, UserEntity>> register(String name, String email, String password) async {
    try {
      final user = await remoteDataSource.register(name, email, password);
      return Right(user);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, UserEntity>> getProfile() async {
    try {
      final user = await remoteDataSource.getProfile();
      return Right(user);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
