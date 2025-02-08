import '../entities/user_entity.dart';

abstract class IAuthRepository {
  Future<UserEntity?> signInWithEmail(String email, String password);
  Future<UserEntity?> signUpWithEmail(String email, String password);
  Future<UserEntity?> signInWithGoogle();
  Future<UserEntity?> signInWithPhone(
      String phoneNumber, Function(String, int?) codeSent);
  Future<UserEntity?> verifyPhone(String verificationId, String smsCode);
  Future<void> signOut();
}
