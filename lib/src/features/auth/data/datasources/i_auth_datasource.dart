import 'package:dartz/dartz.dart';

import '../models/user_model.dart';

abstract class IAuthDataSource {
  Future<UserModel?> signIn(String email, String password);
  Future<UserModel?> signUp(String email, String password);
  Future<Unit> signInWithOtp(String phone);
  Future<UserModel> authUser();
  Future<Unit> signOut();
  Future<bool> isSignIn();
}
