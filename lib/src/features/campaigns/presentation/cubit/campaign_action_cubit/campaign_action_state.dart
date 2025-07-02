part of 'campaign_action_cubit.dart';

sealed class CampaignActionState extends Equatable {
  const CampaignActionState();

  @override
  List<Object> get props => [];
}

final class CampaignActionInitial extends CampaignActionState {}

final class CampaignActionLoading extends CampaignActionState {}

final class CampaignActionSuccess extends CampaignActionState {}

final class CampaignActionError extends CampaignActionState {
  final String message;

  const CampaignActionError({required this.message});

  @override
  List<Object> get props => [message];
}
