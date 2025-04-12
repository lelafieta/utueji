part of 'solidary_cubit.dart';

sealed class SolidaryState extends Equatable {
  const SolidaryState();

  @override
  List<Object> get props => [];
}

final class SolidaryInitial extends SolidaryState {}

final class GetUserDataSuccessState extends SolidaryState {
  final UserEntity user;

  const GetUserDataSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

final class GetUserDataLoadingState extends SolidaryState {}

final class GetUserDataErrorState extends SolidaryState {
  final String error;

  const GetUserDataErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
