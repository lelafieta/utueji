abstract class CampaignFavoriteState {}

class CampaignFavoriteInitial extends CampaignFavoriteState {}

class CampaignFavoriteSuccess extends CampaignFavoriteState {
  final bool isFavorited;

  CampaignFavoriteSuccess({required this.isFavorited});
}

class CampaignFavoriteFailure extends CampaignFavoriteState {}

class CampaignFavoriteLoading extends CampaignFavoriteState {}
