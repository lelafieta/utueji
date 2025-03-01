part of 'campaign_cubit.dart';

sealed class CampaignState extends Equatable {
  const CampaignState();

  @override
  List<Object> get props => [];
}

final class CampaignInitial extends CampaignState {}

final class CampaignLoading extends CampaignState {}

final class CampaignLoaded extends CampaignState {
  final List<CampaignEntity> campaigns;

  const CampaignLoaded({required this.campaigns});

  @override
  List<Object> get props => [campaigns];
}

final class CampaignError extends CampaignState {
  final String message;

  const CampaignError({required this.message});

  @override
  List<Object> get props => [message];
}
