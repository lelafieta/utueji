import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final INetwokInfo networkInfo

  AuthRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Exception, String>> login(String email, String password) async {
    try {
      final accessToken = await remoteDataSource.login(email, password);
      return Right(accessToken);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, String>> register(String name, String email, String password) async {
    try {
      final accessToken = await remoteDataSource.register(name, email, password);
      return Right(accessToken);
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