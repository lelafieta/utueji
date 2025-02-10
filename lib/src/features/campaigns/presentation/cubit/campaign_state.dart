import '../../domain/entities/campaign_entity.dart';

abstract class CampaignState {}

class CampaignInitial extends CampaignState {}

class CampaignLoading extends CampaignState {}

class CampaignLoaded extends CampaignState {
  final List<CampaignEntity> campaigns;

  CampaignLoaded({required this.campaigns});
}

class CampaignFailure extends CampaignState {
  final String failure;

  CampaignFailure({required this.failure});
}
