part of 'ong_action_cubit.dart';

sealed class OngActionState extends Equatable {
  const OngActionState();

  @override
  List<Object> get props => [];
}

final class OngActionInitial extends OngActionState {}

final class OngActionLoading extends OngActionState {}

final class OngActionSuccess extends OngActionState {
  const OngActionSuccess();

  @override
  List<Object> get props => [];
}

final class OngActionFailure extends OngActionState {
  final String error;

  const OngActionFailure({required this.error});

  @override
  List<Object> get props => [error];
}
