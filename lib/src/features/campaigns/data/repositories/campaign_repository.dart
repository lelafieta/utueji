import '../../domain/entities/campaign_entity.dart';
import '../../domain/repositories/i_campaign_repository.dart';
import '../datasources/i_campaign_datasource.dart';

class CampaignRepository implements ICampaignRepository {
  final ICampaignRemoteDataSource campaignDataSource;

  CampaignRepository({required this.campaignDataSource});

  @override
  Stream<List<CampaignEntity>> getCampaigns() {
    return campaignDataSource.fetchCampaigns();
  }

  @override
  Stream<CampaignEntity> getCampaignById(String id) {
    return campaignDataSource.fetchCampaignById(id);
  }

  @override
  Future<void> createCampaign(CampaignEntity campaign) async {
    await campaignDataSource.addCampaign(campaign);
  }

  @override
  Future<void> updateCampaign(CampaignEntity campaign) async {
    await campaignDataSource.editCampaign(campaign);
  }

  @override
  Future<void> deleteCampaign(String id) async {
    await campaignDataSource.removeCampaign(id);
  }

  @override
  Stream<List<CampaignEntity>> getLatestCampaigns() {
    return campaignDataSource.fetchLatestCampaigns();
  }
}
