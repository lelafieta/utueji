import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  AuthCubit({
    required this.registerUseCase,
    required this.loginUseCase,
    required this.getProfileUseCase,
  }) : super(AuthInitial());

  Future<void> register(String name, String email, String password) async {
    emit(AuthLoading());
    final result = await registerUseCase(name, email, password);
    result.fold(
      (failure) => emit(AuthError(message: failure.toString())),
      (accessToken) => emit(AuthSuccess(accessToken: accessToken)),
    );
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await loginUseCase(email, password);
    result.fold(
      (failure) => emit(AuthError(message: failure.toString())),
      (accessToken) => emit(AuthSuccess(accessToken: accessToken)),
    );
  }

  Future<void> getProfile() async {
    emit(AuthLoading());
    final result = await getProfileUseCase();
    result.fold(
      (failure) => emit(AuthError(message: failure.toString())),
      (user) => emit(AuthSuccess(user: user)),
    );
  }
}
