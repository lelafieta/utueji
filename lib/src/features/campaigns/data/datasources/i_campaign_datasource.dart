import '../../domain/entities/campaign_entity.dart';

abstract class ICampaignRemoteDataSource {
  Future<List<CampaignEntity>> getAllCampaigns();
  Future<List<CampaignEntity>> getAllUrgentCampaigns();
  Future<List<CampaignEntity>> getLatestUrgentCampaigns();
  Future<CampaignEntity> getCampaignById(String id);
  Future<void> createCampaign(CampaignEntity campaign);
  Future<void> updateCampaign(CampaignEntity campaign);
  Future<void> deleteCampaign(String id);
}
