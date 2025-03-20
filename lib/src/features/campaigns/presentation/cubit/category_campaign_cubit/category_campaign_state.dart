import '../../../domain/entities/campaign_entity.dart';

abstract class CategoryCampaignState {}

class CategoryCampaignInitial extends CategoryCampaignState {}

class CategoryCampaignLoading extends CategoryCampaignState {
  final List<CampaignEntity> oldCampaigns;
  final bool isFirstFetch;

  CategoryCampaignLoading(this.oldCampaigns, {this.isFirstFetch = false});
}

class CategoryCampaignLoaded extends CategoryCampaignState {
  final List<CampaignEntity> campaigns;
  final bool isLastPage;

  CategoryCampaignLoaded({required this.campaigns, required this.isLastPage});
}

class CategoryCampaignError extends CategoryCampaignState {
  final String message;

  CategoryCampaignError({required this.message});
}
