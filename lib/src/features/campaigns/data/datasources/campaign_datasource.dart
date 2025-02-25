import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/supabase/supabase_consts.dart';
import '../../domain/entities/campaign_entity.dart';
import '../models/campaign_model.dart';
import 'i_campaign_datasource.dart';

class CampaignRemoteDataSource extends ICampaignRemoteDataSource {
  final SupabaseClient supabase;

  CampaignRemoteDataSource({
    required this.supabase,
  });

  @override
  Future<void> addCampaign(CampaignEntity campaign) {
    throw UnimplementedError();
  }

  @override
  Future<void> editCampaign(CampaignEntity need) {
    throw UnimplementedError();
  }

  @override
  Stream<CampaignEntity> fetchCampaignById(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<CampaignEntity>> fetchCampaigns() {
    final campaigns = supabase
        .from(SupabaseConsts.campaigns)
        .stream(primaryKey: ['id'])
        .eq('id', 120)
        .order('is')
        .limit(10);

    // Mapear os dados para a lista de CampaignEntity
    return campaigns.map((data) {
      return data.map((campaign) => CampaignModel.fromJson(campaign)).toList();
    });
  }

  @override
  Future<void> removeCampaign(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<CampaignEntity>> fetchLatestCampaigns() {
    final campaigns = supabase
        .from(SupabaseConsts.campaigns)
        .select("*, user:profiles(*), ong:ongs(*), category:categories(*)")
        .order('created_at')
        .limit(10)
        .asStream()
        .map((data) {
      return data.map((campaign) => CampaignModel.fromJson(campaign)).toList();
    });

    return campaigns;
  }
}
