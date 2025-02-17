import '../models/user_model.dart';

abstract class IAuthDataSource {
  Future<UserModel?> signIn(String email, String password);
  Future<UserModel?> signUp(String email, String password);
  Future<void> signOut();
  Future<bool> isSignIn();
}
