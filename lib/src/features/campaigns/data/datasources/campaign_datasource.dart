import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utueji/src/features/campaigns/domain/entities/campaign_contributor_entity.dart';

import '../../../../core/supabase/supabase_consts.dart';
import '../../domain/entities/campaign_entity.dart';
import '../models/campaign_contribuitor_model.dart';
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
    return supabase
        .from(SupabaseConsts.campaigns)
        .stream(primaryKey: ['id'])
        .order("created_at")
        .limit(10)
        .asyncMap((data) async {
          return Future.wait(data.map((campaign) async {
            // Buscar os contribuidores da campanha
            final contributorsMap = await supabase
                .from(SupabaseConsts.campaignContributors)
                .select("*, user:profiles(*)")
                .eq('campaign_id', campaign['id']);

            List<CampaignContributorModel> contributoresList = contributorsMap
                .map((e) => CampaignContributorModel.fromJson(e))
                .toList();

            campaign["campaign_contributor"] = contributorsMap;

            CampaignModel? campaignObj = CampaignModel.fromJson(campaign);

            campaignObj.campaignContributors = contributoresList;

            return CampaignModel.fromJson(campaign);
          }));
        });
  }
}
