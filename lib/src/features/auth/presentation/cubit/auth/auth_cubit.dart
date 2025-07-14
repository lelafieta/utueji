import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/params/login_params.dart';
import '../../../domain/params/register_params.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  AuthCubit({required this.registerUseCase, required this.loginUseCase})
    : super(AuthInitial());

  Future<void> register(RegisterParams params) async {
    emit(AuthLoading());
    final result = await registerUseCase(params);
    result.fold(
      (failure) => emit(AuthError(message: failure.toString())),
      (accessToken) => emit(AuthSuccess(accessToken: accessToken)),
    );
  }

  Future<void> login(LoginParams params) async {
    emit(AuthLoading());
    final result = await loginUseCase(params);
    result.fold(
      (failure) => emit(AuthError(message: failure.toString())),
      (accessToken) => emit(AuthSuccess(accessToken: accessToken)),
    );
  }

 
}
