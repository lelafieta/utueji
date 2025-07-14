import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/params/login_params.dart';
import '../../../domain/params/register_params.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final FlutterSecureStorage secureStorage;

  AuthCubit({
    required this.registerUseCase,
    required this.loginUseCase,
    required this.secureStorage,
  }) : super(AuthInitial());

  Future<void> register(RegisterParams params) async {
    emit(AuthLoading());
    final result = await registerUseCase(params);
    result.fold(
      (failure) => emit(AuthError(message: failure.toString())),
      (accessToken) async {
        await secureStorage.write(key: 'access_token', value: accessToken);
        emit(AuthSuccess(accessToken: accessToken));
      },
    );
  }

  Future<void> login(LoginParams params) async {
    emit(AuthLoading());
    final result = await loginUseCase(params);
    result.fold(
      (failure) => emit(AuthError(message: failure.toString())),
      (accessToken) async {
        await secureStorage.write(key: 'access_token', value: accessToken);
        emit(AuthSuccess(accessToken: accessToken));
      },
    );
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'access_token');
    emit(AuthInitial());
  }

  Future<void> checkLoginStatus() async {
    final token = await secureStorage.read(key: 'access_token');
    if (token != null) {
      emit(AuthSuccess(accessToken: token));
    } else {
      emit(AuthInitial());
    }
  }
}
