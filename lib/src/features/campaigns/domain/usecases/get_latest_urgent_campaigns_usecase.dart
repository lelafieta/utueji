import '../entities/campaign_entity.dart';
import '../repositories/i_campaign_repository.dart';

class GetLatestUrgentCampaignsUseCase {
  final ICampaignRepository repository;

  GetLatestUrgentCampaignsUseCase({required this.repository});

  Stream<List<CampaignEntity>> call() {
    return repository.getLatestUrgentCampaigns();
  }
}
