import '../../domain/entities/campaign_entity.dart';

abstract class ICampaignRemoteDataSource {
  Future<List<CampaignEntity>> getAllCampaigns(
      {required int page, required int limit});
  Future<List<CampaignEntity>> getAllMyCampaigns(
      {required int page, required int limit});
  Future<List<CampaignEntity>> getAllUrgentCampaigns(
      {required int page, required int limit});
  Future<List<CampaignEntity>> getLatestUrgentCampaigns(
      {required int page, required int limit});
  Future<CampaignEntity> getCampaignById(String id);
  Future<void> createCampaign(CampaignEntity campaign);
  Future<void> updateCampaign(CampaignEntity campaign);
  Future<void> deleteCampaign(String id);
}
