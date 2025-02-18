import '../../domain/entities/campaign_entity.dart';
import '../../domain/repositories/i_campaign_repository.dart';
import '../datasources/i_campaign_datasource.dart';

class CampaignRepository implements ICampaignRepository {
  final ICampaignRemoteDataSource repository;

  CampaignRepository({required this.repository});

  @override
  Stream<List<CampaignEntity>> getCampaigns() {
    return repository.fetchCampaigns();
  }

  @override
  Stream<CampaignEntity> getCampaignById(String id) {
    return repository.fetchCampaignById(id);
  }

  @override
  Future<void> createCampaign(CampaignEntity campaign) async {
    await repository.addCampaign(campaign);
  }

  @override
  Future<void> updateCampaign(CampaignEntity campaign) async {
    await repository.editCampaign(campaign);
  }

  @override
  Future<void> deleteCampaign(String id) async {
    await repository.removeCampaign(id);
  }

  @override
  Stream<List<CampaignEntity>> getLatestCampaigns() {
    print("CHEGOU!!!!!");
    return repository.fetchLatestCampaigns();
  }
}
