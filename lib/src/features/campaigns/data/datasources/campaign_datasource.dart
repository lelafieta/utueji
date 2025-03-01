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
  Future<void> createCampaign(CampaignEntity campaign) {
    // TODO: implement createCampaign
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCampaign(String id) {
    // TODO: implement deleteCampaign
    throw UnimplementedError();
  }

  @override
  Future<List<CampaignEntity>> getAllCampaigns() async {
    final userId = supabase.auth.currentUser!.id;
    final response = await supabase.from(SupabaseConsts.campaigns).select('''
      *, 
      user:profiles(*), 
      ong:ongs(*), 
      category:categories(*), 
      contributors:campaign_contributors(*, user:profiles(*)), 
      documents:campaign_documents(*), 
      updates:campaign_updates(*), 
      comments:campaign_comments(*, user:profiles(*))
    ''').eq('user_id', userId).order('created_at');

    return response.map((event) => CampaignModel.fromJson(event)).toList();
  }

  @override
  Future<List<CampaignEntity>> getAllUrgentCampaigns() async {
    final userId = supabase.auth.currentUser!.id;

    final response = await supabase.from(SupabaseConsts.campaigns).select('''
      *, 
      user:profiles(*), 
      ong:ongs(*), 
      category:categories(*), 
      contributors:campaign_contributors(*, user:profiles(*)), 
      documents:campaign_documents(*), 
      updates:campaign_updates(*), 
      comments:campaign_comments(*, user:profiles(*))
    ''').eq('is_urgent', true).eq('user_id', userId).order('created_at');

    return response.map((event) => CampaignModel.fromJson(event)).toList();
  }

  @override
  Future<CampaignEntity> getCampaignById(String id) async {
    final userId = supabase.auth.currentUser!.id;
    final response = await supabase
        .from(SupabaseConsts.campaigns)
        .select('''
      *, 
      user:profiles(*), 
      ong:ongs(*), 
      category:categories(*), 
      contributors:campaign_contributors(*, user:profiles(*)), 
      documents:campaign_documents(*), 
      updates:campaign_updates(*), 
      comments:campaign_comments(*, user:profiles(*))
    ''')
        .eq('id', id)
        .eq('user_id', userId)
        .order('created_at')
        .limit(10)
        .single();

    return CampaignModel.fromJson(response);
  }

  @override
  Future<List<CampaignEntity>> getLatestUrgentCampaigns() async {
    final userId = supabase.auth.currentUser!.id;

    final response = await supabase
        .from(SupabaseConsts.campaigns)
        .select('''
      *, 
      user:profiles(*), 
      ong:ongs(*), 
      category:categories(*), 
      contributors:campaign_contributors(*, user:profiles(*)), 
      documents:campaign_documents(*), 
      updates:campaign_updates(*), 
      comments:campaign_comments(*, user:profiles(*))
    ''')
        .eq('is_urgent', true)
        .eq('user_id', userId)
        .order('created_at')
        .limit(10);

    return response.map((event) => CampaignModel.fromJson(event)).toList();
  }

  @override
  Future<void> updateCampaign(CampaignEntity campaign) {
    // TODO: implement updateCampaign
    throw UnimplementedError();
  }
}
