import '../../../../campaigns/domain/entities/campaign_entity.dart';

abstract class HomeCampaignState {}

class HomeCampaignInitial extends HomeCampaignState {}

class HomeCampaignLoading extends HomeCampaignState {}

class HomeCampaignLoaded extends HomeCampaignState {
  final List<CampaignEntity> campaigns;

  HomeCampaignLoaded({required this.campaigns});
}

class HomeCampaignError extends HomeCampaignState {
  final String message;

  HomeCampaignError({required this.message});
}
