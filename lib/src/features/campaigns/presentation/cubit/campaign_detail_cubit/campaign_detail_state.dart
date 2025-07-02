import 'package:equatable/equatable.dart';

import '../../../domain/entities/campaign_entity.dart';

sealed class CampaignDetailState extends Equatable {
  const CampaignDetailState();

  @override
  List<Object> get props => [];
}

class CampaignDetailInitial extends CampaignDetailState {}

class CampaignDetailLoading extends CampaignDetailState {}

class CampaignDetailLoaded extends CampaignDetailState {
  final CampaignEntity campaign;

  CampaignDetailLoaded({required this.campaign});
}

class CampaignDetailError extends CampaignDetailState {
  final String message;

  CampaignDetailError({required this.message});
}
