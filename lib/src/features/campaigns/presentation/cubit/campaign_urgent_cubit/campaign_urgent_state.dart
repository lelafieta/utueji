import '../../../domain/entities/campaign_entity.dart';

abstract class CampaignUrgentState {}

class CampaignUrgentInitial extends CampaignUrgentState {}

class CampaignUrgentLoading extends CampaignUrgentState {}

class CampaignUrgentLoaded extends CampaignUrgentState {
  final List<CampaignEntity> campaigns;

  CampaignUrgentLoaded({required this.campaigns});
}

class CampaignUrgentError extends CampaignUrgentState {
  final String message;

  CampaignUrgentError({required this.message});
}
