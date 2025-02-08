import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/sign_in_with_email_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import '../../domain/usecases/sign_in_with_phone_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_with_email_usecase.dart';
import '../../domain/usecases/verify_phone_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithEmailUseCase signInWithEmailUseCase;
  final SignUpWithEmailUseCase signUpWithEmailUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SignInWithPhoneUseCase signInWithPhoneUseCase;
  final SignOutUseCase signOutUseCase;
  final VerifyPhoneUseCase verifyPhoneUseCase;

  AuthCubit({
    required this.signInWithEmailUseCase,
    required this.signUpWithEmailUseCase,
    required this.signInWithGoogleUseCase,
    required this.signOutUseCase,
    required this.verifyPhoneUseCase,
    required this.signInWithPhoneUseCase,
  }) : super(AuthInitial());

  Future<void> loginWithEmail(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await signInWithEmailUseCase(email, password);
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(AuthFailure(failure: "Falha no login"));
      }
    } catch (e) {
      emit(AuthFailure(failure: e.toString()));
    }
  }

  Future<void> registerWithEmail(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await signUpWithEmailUseCase(email, password);
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(AuthFailure(failure: "Falha no registro"));
      }
    } catch (e) {
      emit(AuthFailure(failure: e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());
    try {
      final user = await signInWithGoogleUseCase.call();
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(AuthFailure(failure: "Falha no login com Google"));
      }
    } catch (e) {
      emit(AuthFailure(failure: e.toString()));
    }
  }

  Future<void> loginWithPhone(
      String phoneNumber, Function(String, int?) codeSent) async {
    emit(AuthLoading());
    try {
      await signInWithPhoneUseCase.call(phoneNumber, codeSent);
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(failure: e.toString()));
    }
  }

  Future<void> verifyPhoneCode(String verificationId, String smsCode) async {
    emit(AuthLoading());
    try {
      final user = await verifyPhoneUseCase.call(verificationId, smsCode);
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(AuthFailure(failure: "Falha na verificação do código"));
      }
    } catch (e) {
      emit(AuthFailure(failure: e.toString()));
    }
  }
}
