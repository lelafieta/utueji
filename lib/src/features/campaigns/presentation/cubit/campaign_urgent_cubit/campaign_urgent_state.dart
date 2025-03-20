import '../../../domain/entities/campaign_entity.dart';

abstract class CampaignUrgentState {}

class CampaignUrgentInitial extends CampaignUrgentState {}

class CampaignUrgentLoading extends CampaignUrgentState {
  final List<CampaignEntity> oldCampaigns;
  final bool isFirstFetch;

  CampaignUrgentLoading(this.oldCampaigns, {this.isFirstFetch = false});
}

class CampaignUrgentLoaded extends CampaignUrgentState {
  final List<CampaignEntity> campaigns;
  final bool isLastPage;

  CampaignUrgentLoaded({required this.campaigns, required this.isLastPage});
}

class CampaignUrgentError extends CampaignUrgentState {
  final String message;

  CampaignUrgentError({required this.message});
}
