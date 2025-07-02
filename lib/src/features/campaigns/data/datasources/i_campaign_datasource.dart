import '../../domain/entities/campaign_entity.dart';
import '../../domain/entities/campaign_params.dart';

abstract class ICampaignRemoteDataSource {
  Future<List<CampaignEntity>> getAllCampaigns(CampaignParams params);
  Future<List<CampaignEntity>> getAllMyCampaigns(CampaignParams params);
  Future<List<CampaignEntity>> getAllUrgentCampaigns(CampaignParams params);
  Future<List<CampaignEntity>> getLatestUrgentCampaigns(CampaignParams params);
  Future<CampaignEntity> getCampaignById(String id);
  Future<void> createCampaign(CampaignEntity campaign);
  Future<void> updateCampaign(CampaignEntity campaign);
  Future<void> deleteCampaign(String id);
}
