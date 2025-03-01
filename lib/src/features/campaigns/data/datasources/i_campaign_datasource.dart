import '../../domain/entities/campaign_entity.dart';

abstract class ICampaignRemoteDataSource {
  Stream<List<CampaignEntity>> fetchCampaigns();
  Stream<List<CampaignEntity>> fetchLatestUrgentCampaigns();
  Stream<CampaignEntity> fetchCampaignById(String id);
  Future<void> addCampaign(CampaignEntity campaign);
  Future<void> editCampaign(CampaignEntity campaign);
  Future<void> removeCampaign(String id);
}
