import '../entities/campaign_entity.dart';

abstract class ICampaignRepository {
  Stream<List<CampaignEntity>> getCampaigns();
  Stream<List<CampaignEntity>> getLatestCampaigns();
  Stream<CampaignEntity> getCampaignById(String id);
  Future<void> createCampaign(CampaignEntity need);
  Future<void> updateCampaign(CampaignEntity need);
  Future<void> deleteCampaign(String id);
}
