part of 'auth_data_cubit.dart';

sealed class AuthDataState extends Equatable {
  const AuthDataState();

  @override
  List<Object> get props => [];
}

final class AuthDataInitial extends AuthDataState {}

final class AuthDataLoading extends AuthDataState {}

final class AuthDataLoaded extends AuthDataState {
  final UserEntity currentUser;

  const AuthDataLoaded({required this.currentUser});

  @override
  List<Object> get props => [currentUser];
}

final class AuthDataError extends AuthDataState {
  final String message;

  const AuthDataError({required this.message});

  @override
  List<Object> get props => [message];
}
