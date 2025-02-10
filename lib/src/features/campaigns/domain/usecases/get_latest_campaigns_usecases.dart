import '../entities/campaign_entity.dart';
import '../repositories/i_campaign_repository.dart';

class GetLatestCampaignsUseCase {
  final ICampaignRepository repository;

  GetLatestCampaignsUseCase({required this.repository});

  Stream<List<CampaignEntity>> call() {
    return repository.getLatestCampaigns();
  }
}
