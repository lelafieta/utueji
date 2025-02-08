import '../models/user_model.dart';

abstract class IAuthDataSource {
  Future<UserModel?> signInWithEmail(String email, String password);
  Future<UserModel?> signUpWithEmail(String email, String password);
  Future<UserModel?> signInWithGoogle();
  Future<UserModel?> signInWithPhone(
      String phoneNumber, Function(String, int?) codeSent);
  Future<UserModel?> verifyPhone(String verificationId, String smsCode);
  Future<void> signOut();
}
