import '../entities/campaign_entity.dart';
import '../repositories/i_campaign_repository.dart';

class GetCampaignsUseCase {
  final ICampaignRepository repository;

  GetCampaignsUseCase({required this.repository});

  Stream<List<CampaignEntity>> call() {
    return repository.getCampaigns();
  }
}
