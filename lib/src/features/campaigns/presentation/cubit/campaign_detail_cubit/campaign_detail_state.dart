import '../../../domain/entities/campaign_entity.dart';

abstract class CampaignDetailState {}

class CampaignDetailInitial extends CampaignDetailState {}

class CampaignDetailLoading extends CampaignDetailState {}

class CampaignDetailLoaded extends CampaignDetailState {
  final CampaignEntity campaign;

  CampaignDetailLoaded({required this.campaign});
}

class CampaignDetailFailure extends CampaignDetailState {
  final String failure;

  CampaignDetailFailure({required this.failure});
}
