abstract class ProfileNeedState {}

class ProfileNeedInitial extends ProfileNeedState {}

class ProfileNeedLoading extends ProfileNeedState {}

class ProfileNeedLoaded extends ProfileNeedState {}

class ProfileNeedFailure extends ProfileNeedState {
  final String failure;

  ProfileNeedFailure({required this.failure});
}
