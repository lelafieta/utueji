import '../../domain/entities/campaign_entity.dart';
import '../../domain/repositories/i_campaign_repository.dart';
import '../datasources/i_campaign_datasource.dart';

class CampaignRepository implements ICampaignRepository {
  final ICampaignRemoteDataSource datasource;

  CampaignRepository({required this.datasource});

  @override
  Stream<List<CampaignEntity>> getCampaigns() {
    return datasource.fetchCampaigns();
  }

  @override
  Stream<CampaignEntity> getCampaignById(String id) {
    return datasource.fetchCampaignById(id);
  }

  @override
  Future<void> createCampaign(CampaignEntity campaign) async {
    await datasource.addCampaign(campaign);
  }

  @override
  Future<void> updateCampaign(CampaignEntity campaign) async {
    await datasource.editCampaign(campaign);
  }

  @override
  Future<void> deleteCampaign(String id) async {
    await datasource.removeCampaign(id);
  }

  @override
  Stream<List<CampaignEntity>> getLatestCampaigns() {
    print("CHEGOU!!!!!");
    return datasource.fetchLatestCampaigns();
  }
}
