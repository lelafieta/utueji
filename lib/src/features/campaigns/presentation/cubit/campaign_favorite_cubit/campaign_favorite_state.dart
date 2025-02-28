import 'package:utueji/src/features/favorites/domain/entities/favorite_entity.dart';

abstract class CampaignFavoriteState {}

class CampaignFavoriteInitial extends CampaignFavoriteState {}

class CampaignFavoriteSuccess extends CampaignFavoriteState {
  final bool isFavorited;

  CampaignFavoriteSuccess({required this.isFavorited});
}

class CampaignFavoriteLoaded extends CampaignFavoriteState {
  final List<FavoriteEntity> favorites;

  CampaignFavoriteLoaded({required this.favorites});
}

class CampaignFavoriteFailure extends CampaignFavoriteState {
  final String failure;

  CampaignFavoriteFailure({required this.failure});
}

class CampaignFavoriteLoading extends CampaignFavoriteState {}
