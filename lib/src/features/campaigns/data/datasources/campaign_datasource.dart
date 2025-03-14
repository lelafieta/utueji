import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
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
  Future<void> createCampaign(CampaignEntity campaign) async {
    try {
      String? imageCoverUrl;
      List<String>? midiaImagesPathes;
      List<String>? documentImagesPathes;

      File? coverImageFile;

      if (supabase.auth.currentUser != null) {
        print("ESTÁ AUTENTICADO");
      } else {
        print("NÃO AUTENTICADO");
      }

      if (campaign.imageCoverUrl != null) {
        final uuid = Uuid().v4();
        final imageFile = File(campaign.imageCoverUrl!);
        final fileName = "${DateTime.now()}${uuid}.jpg";
        final storageResponse = await supabase.storage
            .from(SupabaseConsts.campaigns)
            .upload(fileName, imageFile);

        if (storageResponse.isNotEmpty) {
          imageCoverUrl = supabase.storage
              .from(SupabaseConsts.campaigns)
              .getPublicUrl(fileName);

          final newCampaign = CampaignModel(
            id: uuid,
            categoryId: campaign.categoryId,
            title: campaign.title,
            description: campaign.description,
            fundraisingGoal: campaign.fundraisingGoal,
            fundsRaised: campaign.fundsRaised,
            imageCoverUrl: imageCoverUrl,
            currency: campaign.currency,
            startDate: campaign.startDate,
            endDate: campaign.endDate,
            location: campaign.location,
            campaignType: campaign.campaignType,
            beneficiaryName: campaign.beneficiaryName,
            phoneNumber: campaign.phoneNumber,
            isUrgent: campaign.isUrgent,
            userId: supabase.auth.currentUser!.id,
            isActivate: true,
            numberOfContributions: 0,
            ongId: campaign.ongId,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ).toMap();

          await supabase.from(SupabaseConsts.campaigns).insert(newCampaign);
        }
      }
    } catch (e) {
      print("ERRORROROROR $e");
      throw e;
    }
  }

  @override
  Future<void> deleteCampaign(String id) {
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
      comments:campaign_comments(*, user:profiles(*)),
      midias:campaign_midias(*)
    ''').eq('user_id', userId).eq('is_activate', true).order('created_at');

    return response.map((event) => CampaignModel.fromJson(event)).toList();
  }

  @override
  Future<List<CampaignEntity>> getAllUrgentCampaigns() async {
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
      comments:campaign_comments(*, user:profiles(*)),
      midias:campaign_midias(*)
    ''')
        .eq('is_urgent', true)
        .eq('is_activate', true)
        .eq('user_id', userId)
        .order('created_at');

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
      comments:campaign_comments(*, user:profiles(*)),
      midias:campaign_midias(*)
    ''')
        .eq('id', id)
        .eq('is_activate', true)
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
      comments:campaign_comments(*, user:profiles(*)),
      midias:campaign_midias(*)
    ''')
        .eq('is_urgent', true)
        .eq('is_activate', true)
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .limit(10);

    return response.map((event) => CampaignModel.fromJson(event)).toList();
  }

  @override
  Future<void> updateCampaign(CampaignEntity campaign) {
    throw UnimplementedError();
  }

  @override
  Future<List<CampaignEntity>> getAllMyCampaigns() async {
    final userId = supabase.auth.currentUser!.id;
    final response = await supabase.from(SupabaseConsts.campaigns).select('''
      *, 
      user:profiles(*), 
      ong:ongs(*), 
      category:categories(*), 
      contributors:campaign_contributors(*, user:profiles(*)), 
      documents:campaign_documents(*), 
      updates:campaign_updates(*), 
      comments:campaign_comments(*, user:profiles(*)),
      midias:campaign_midias(*)
    ''').eq('user_id', userId).order('created_at');

    return response.map((event) => CampaignModel.fromJson(event)).toList();
  }
}
