import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:utueji/src/features/auth/domain/entities/user_entity.dart';
import 'package:utueji/src/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:utueji/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:utueji/src/features/auth/domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final GetProfileUseCase getProfileUseCase;

  AuthBloc({
    required this.registerUseCase,
    required this.loginUseCase,
    required this.getProfileUseCase,
  }) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegisterEvent);
    on<LoginEvent>(_onLoginEvent);
    on<GetProfileEvent>(_onGetProfileEvent);
  }

  void _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await registerUseCase(event.name, event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onGetProfileEvent(GetProfileEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await getProfileUseCase();
    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
