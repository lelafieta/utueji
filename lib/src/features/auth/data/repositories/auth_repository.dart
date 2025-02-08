import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/i_auth_datasource.dart';

class AuthRespository extends IAuthRepository {
  final IAuthDataSource authDataSource;

  AuthRespository({required this.authDataSource});

  @override
  Future<UserEntity?> signInWithEmail(String email, String password) =>
      authDataSource.signInWithEmail(email, password);

  @override
  Future<UserEntity?> signUpWithEmail(String email, String password) =>
      authDataSource.signUpWithEmail(email, password);

  @override
  Future<UserEntity?> signInWithGoogle() => authDataSource.signInWithGoogle();

  @override
  Future<UserEntity?> signInWithPhone(
          String phoneNumber, Function(String, int?) codeSent) =>
      authDataSource.signInWithPhone(phoneNumber, codeSent);

  @override
  Future<UserEntity?> verifyPhone(String verificationId, String smsCode) =>
      authDataSource.verifyPhone(verificationId, smsCode);

  @override
  Future<void> signOut() => authDataSource.signOut();

  @override
  Future<bool> isSignIn() => authDataSource.isSignIn();
}
