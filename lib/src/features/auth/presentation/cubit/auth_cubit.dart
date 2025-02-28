import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/secure_storage.dart';
import '../../domain/entities/login_parameters.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final SecureCacheHelper secureCacheHelper;

  AuthCubit(
      {required this.signInUseCase,
      required this.signUpUseCase,
      required this.signOutUseCase,
      required this.secureCacheHelper})
      : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final response = await signInUseCase
        .call(LoginParameters(email: email, password: password));

    response.fold(
      (failure) => emit(AuthFailure(failure: failure.error.toString())),
      (user) {
        secureCacheHelper.saveData(key: "uid", value: user!.id!);
        emit(Authenticated(user: user));
      },
    );
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
  }
}
