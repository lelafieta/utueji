import 'package:equatable/equatable.dart';

import '../../../domain/entities/campaign_entity.dart';

sealed class MyCampaignState extends Equatable {
  const MyCampaignState();

  @override
  List<Object> get props => [];
}

final class MyCampaignInitial extends MyCampaignState {}

final class MyCampaignLoading extends MyCampaignState {
  final List<CampaignEntity> oldCampaigns;
  final bool isFirstFetch;

  MyCampaignLoading(this.oldCampaigns, {this.isFirstFetch = false});
}

final class MyCampaignLoaded extends MyCampaignState {
  final List<CampaignEntity> campaigns;
  final bool isLastPage;

  const MyCampaignLoaded({required this.campaigns, required this.isLastPage});

  @override
  List<Object> get props => [campaigns];
}

final class MyCampaignError extends MyCampaignState {
  final String message;

  const MyCampaignError({required this.message});

  @override
  List<Object> get props => [message];
}
