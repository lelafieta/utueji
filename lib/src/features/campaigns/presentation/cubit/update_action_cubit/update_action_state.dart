abstract class UpdateActionState {
  const UpdateActionState();
}

class UpdateActionInitial extends UpdateActionState {
  const UpdateActionInitial();
}

class UpdateActionLoading extends UpdateActionState {
  const UpdateActionLoading();
}

class UpdateActionSuccess extends UpdateActionState {
  const UpdateActionSuccess();
}

class UpdateActionFailure extends UpdateActionState {
  final String message;
  const UpdateActionFailure({required this.message});
}
