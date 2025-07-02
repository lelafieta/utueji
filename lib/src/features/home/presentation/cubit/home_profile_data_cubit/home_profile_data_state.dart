part of 'home_profile_data_cubit.dart';

sealed class HomeProfileDataState extends Equatable {
  const HomeProfileDataState();

  @override
  List<Object> get props => [];
}

final class HomeProfileDataInitial extends HomeProfileDataState {}

final class HomeProfileDataLoading extends HomeProfileDataState {}

final class HomeProfileDataLoaded extends HomeProfileDataState {
  final UserEntity user;

  HomeProfileDataLoaded({required this.user});
}
