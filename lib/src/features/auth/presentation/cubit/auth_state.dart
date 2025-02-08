import '../../domain/entities/user_entity.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserEntity user;
  Authenticated({required this.user});
}

class AuthFailure extends AuthState {
  final String failure;
  AuthFailure({required this.failure});
}
