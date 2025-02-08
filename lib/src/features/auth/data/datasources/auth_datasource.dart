import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import 'i_auth_datasource.dart';

class AuthDataSource implements IAuthDataSource {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  AuthDataSource({required this.auth, required this.googleSignIn});

  @override
  Future<UserModel?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw Exception("Erro ao fazer login: ${e.toString()}");
    }
  }

  @override
  Future<UserModel?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw Exception("Erro ao registrar: ${e.toString()}");
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw Exception("Erro ao autenticar com Google: ${e.toString()}");
    }
  }

  @override
  Future<UserModel?> signInWithPhone(
      String phoneNumber, Function(String, int?) codeSent) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception("Falha na verificação: ${e.message}");
        },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return null;
    } catch (e) {
      throw Exception("Erro ao enviar código: ${e.toString()}");
    }
  }

  @override
  Future<UserModel?> verifyPhone(String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw Exception("Erro ao verificar código: ${e.toString()}");
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;
}
