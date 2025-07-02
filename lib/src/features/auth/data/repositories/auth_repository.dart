import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:utueji/src/core/errors/failures.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/i_auth_datasource.dart';

class AuthRespository extends IAuthRepository {
  final IAuthDataSource datasource;

  AuthRespository({required this.datasource});

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      final response = await datasource.isSignIn();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(
      {required String email, required String password}) async {
    try {
      UserEntity? response = await datasource.signIn(email, password);
      return Right(response!);
    } catch (e) {
      debugPrint("object ${e}");
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await datasource.signOut();
      return Right(unit);
    } catch (e) {
      debugPrint("object ${e}");
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> signInWithOtp(String phone) async {
    try {
      await datasource.signInWithOtp(phone);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> authUser() async {
    try {
      UserEntity? response = await datasource.authUser();
      return Right(response);
    } catch (e) {
      debugPrint("object ${e}");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
