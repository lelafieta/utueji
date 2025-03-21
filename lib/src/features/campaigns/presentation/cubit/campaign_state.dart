import 'package:equatable/equatable.dart';

import '../../domain/entities/campaign_entity.dart';

sealed class CampaignState extends Equatable {
  const CampaignState();

  @override
  List<Object> get props => [];
}

final class CampaignInitial extends CampaignState {}

final class CampaignLoading extends CampaignState {
  final List<CampaignEntity> oldCampaigns;
  final bool isFirstFetch;

  CampaignLoading(this.oldCampaigns, {this.isFirstFetch = false});
}

final class CampaignLoaded extends CampaignState {
  final List<CampaignEntity> campaigns;
  final bool isLastPage;

  const CampaignLoaded({required this.campaigns, required this.isLastPage});

  @override
  List<Object> get props => [campaigns];
}

final class CampaignError extends CampaignState {
  final String message;

  const CampaignError({required this.message});

  @override
  List<Object> get props => [message];
}
