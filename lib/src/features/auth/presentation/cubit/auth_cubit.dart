import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utueji/src/app/app_entity.dart';
import '../../../../core/cache/secure_storage.dart';
import '../../../../core/entities/no_params.dart';
import '../../domain/entities/login_parameters.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_in_with_otp_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final SignInWithOtpUseCase signInWithOtpUseCase;
  final SecureCacheHelper secureCacheHelper;

  AuthCubit(
      {required this.signInUseCase,
      required this.signUpUseCase,
      required this.signOutUseCase,
      required this.secureCacheHelper,
      required this.signInWithOtpUseCase})
      : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final response = await signInUseCase
        .call(LoginParameters(email: email, password: password));

    response.fold(
      (failure) => emit(AuthFailure(failure: failure.message.toString())),
      (user) async {
        await secureCacheHelper.saveData(key: "uid", value: user!.id!);
        await secureCacheHelper.saveData(
            key: "fullName", value: user.fullName!);
        await secureCacheHelper.saveData(
            key: "avatarUrl", value: user.avatarUrl!);

        AppEntity.currentUser = user;

        emit(Authenticated(user: user));
      },
    );
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    final response = await signOutUseCase.call(NoParams());

    response.fold(
      (failure) => emit(AuthFailure(failure: failure.message.toString())),
      (user) {
        secureCacheHelper.saveData(key: "uid", value: "");
        emit(AuthSignedOut());
      },
    );
  }

  Future<void> signInWithOtp(String phone) async {
    emit(AuthLoading());
    final response =
        await signInWithOtpUseCase.call(LoginParameters(phone: phone));

    response.fold(
      (failure) => emit(AuthFailure(failure: failure.message.toString())),
      (user) {
        // secureCacheHelper.saveData(key: "uid", value: "");
        emit(AuthOtpSendSms());
      },
    );
  }
}
