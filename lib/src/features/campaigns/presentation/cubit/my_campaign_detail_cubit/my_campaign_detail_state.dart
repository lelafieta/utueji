import 'package:equatable/equatable.dart';

import '../../../domain/entities/campaign_entity.dart';

sealed class MyCampaignDetailState extends Equatable {
  const MyCampaignDetailState();

  @override
  List<Object> get props => [];
}

class MyCampaignDetailInitial extends MyCampaignDetailState {}

class MyCampaignDetailLoading extends MyCampaignDetailState {}

class MyCampaignDetailLoaded extends MyCampaignDetailState {
  final CampaignEntity campaign;

  MyCampaignDetailLoaded({required this.campaign});
}

class MyCampaignDetailError extends MyCampaignDetailState {
  final String message;

  MyCampaignDetailError({required this.message});
}
