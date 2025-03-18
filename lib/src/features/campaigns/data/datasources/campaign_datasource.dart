import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;
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
      final supabase = Supabase.instance.client; // Conexão com Supabase
      final campaignId = Uuid().v4();
      String? imageCoverUrl;

      // Upload da imagem de capa da campanha
      if (campaign.imageCoverUrl != null) {
        final imageFile = File(campaign.imageCoverUrl!);
        final fileName = "${DateTime.now()}${campaignId}.jpg";

        final storageResponse = await supabase.storage
            .from(SupabaseConsts.campaigns)
            .upload(fileName, imageFile);

        if (storageResponse.isNotEmpty) {
          imageCoverUrl = supabase.storage
              .from(SupabaseConsts.campaigns)
              .getPublicUrl(fileName);
        }
      }

      // Criando JSON para enviar ao Supabase
      final campaignData = {
        "id": campaignId,
        "categoryId": campaign.categoryId,
        "title": campaign.title,
        "description": campaign.description,
        "fundraisingGoal": campaign.fundraisingGoal,
        "fundsRaised": campaign.fundsRaised,
        "imageCoverUrl": imageCoverUrl,
        "currency": campaign.currency,
        "startDate": campaign.startDate?.toIso8601String(),
        "endDate": campaign.endDate?.toIso8601String(),
        "location": campaign.location,
        "campaignType": campaign.campaignType,
        "beneficiaryName": campaign.beneficiaryName,
        "phoneNumber": campaign.phoneNumber,
        "isUrgent": campaign.isUrgent,
        "userId": supabase.auth.currentUser!.id,
        "isActivate": true,
        "numberOfContributions": 0,
        "ongId": campaign.ongId
      };

      // Processamento e Upload de Mídias (Imagens e Vídeos)
      List<Map<String, dynamic>> mediaList = [];
      if (campaign.midias != null && campaign.midias!.isNotEmpty) {
        for (var media in campaign.midias!) {
          final uuid = Uuid().v4();
          final mediaFile = File(media.midiaUrl!);
          final fileExtension =
              path.extension(mediaFile.path).replaceFirst('.', '');

          // Identificando o tipo da mídia (imagem ou vídeo)
          String midiaType =
              (['jpg', 'jpeg', 'png'].contains(fileExtension.toLowerCase()))
                  ? "image"
                  : "video";

          final fileName = "${DateTime.now()}${uuid}.$fileExtension";
          final storageResponse = await supabase.storage
              .from(SupabaseStorageConsts.midias)
              .upload(fileName, mediaFile);

          if (storageResponse.isNotEmpty) {
            final midiaPath = supabase.storage
                .from(SupabaseStorageConsts.midias)
                .getPublicUrl(fileName);

            mediaList.add({
              "id": uuid,
              "midiaType": midiaType,
              "midiaUrl": midiaPath,
            });
          }
        }
      }

      // Processamento e Upload de Documentos
      List<Map<String, dynamic>> documentList = [];
      if (campaign.documents != null && campaign.documents!.isNotEmpty) {
        for (var doc in campaign.documents!) {
          final uuid = Uuid().v4();
          final documentFile = File(doc.documentPath!);
          final fileExtension =
              path.extension(documentFile.path).replaceFirst('.', '');

          final fileName = "${DateTime.now()}${uuid}.$fileExtension";
          final storageResponse = await supabase.storage
              .from(SupabaseStorageConsts.documents)
              .upload(fileName, documentFile);

          if (storageResponse.isNotEmpty) {
            final documentPath = supabase.storage
                .from(SupabaseStorageConsts.documents)
                .getPublicUrl(fileName);

            documentList.add({
              "id": uuid,
              "documentPath": documentPath,
            });
          }
        }
      }

      // Chamando a Stored Procedure do Supabase
      final response = await supabase.rpc(
        'create_campaign_transaction',
        params: {
          'campaign_data': campaignData,
          'media_list': mediaList,
          'document_list': documentList,
        },
      );

      if (response != null) {
        print("Erro ao criar campanha: ${response.error!.message}");
      } else {
        print("✅ Campanha criada com sucesso!");
      }
    } catch (e, strack) {
      print("❌ Erro: $e $strack");
      throw e;
    }
  }
  // Future<void> createCampaign(CampaignEntity campaign) async {
  //   try {
  //     String? imageCoverUrl;
  //     if (campaign.imageCoverUrl != null) {
  //       final campaignId = Uuid().v4();
  //       final imageFile = File(campaign.imageCoverUrl!);
  //       final fileName = "${DateTime.now()}${campaignId}.jpg";
  //       final storageResponse = await supabase.storage
  //           .from(SupabaseConsts.campaigns)
  //           .upload(fileName, imageFile);

  //       if (storageResponse.isNotEmpty) {
  //         imageCoverUrl = supabase.storage
  //             .from(SupabaseConsts.campaigns)
  //             .getPublicUrl(fileName);

  //         final newCampaign = CampaignModel(
  //           id: campaignId,
  //           categoryId: campaign.categoryId,
  //           title: campaign.title,
  //           description: campaign.description,
  //           fundraisingGoal: campaign.fundraisingGoal,
  //           fundsRaised: campaign.fundsRaised,
  //           imageCoverUrl: imageCoverUrl,
  //           currency: campaign.currency,
  //           startDate: campaign.startDate,
  //           endDate: campaign.endDate,
  //           location: campaign.location,
  //           campaignType: campaign.campaignType,
  //           beneficiaryName: campaign.beneficiaryName,
  //           phoneNumber: campaign.phoneNumber,
  //           isUrgent: campaign.isUrgent,
  //           userId: supabase.auth.currentUser!.id,
  //           isActivate: true,
  //           numberOfContributions: 0,
  //           ongId: campaign.ongId,
  //           createdAt: DateTime.now(),
  //           updatedAt: DateTime.now(),
  //         ).toMap();

  //         await supabase.from(SupabaseConsts.campaigns).insert(newCampaign);

  //         if (campaign.midias!.length > 0) {
  //           String midiaType = "";

  //           final allowedImageExtensions = ['jpg', 'jpeg', 'png'];
  //           campaign.midias!.forEach((element) async {
  //             final uuid = Uuid().v4();
  //             final imageFile = File(element.midiaUrl!);
  //             final fileExtension =
  //                 path.extension(imageFile.path).replaceFirst('.', '');

  //             if (allowedImageExtensions
  //                 .contains(fileExtension.toLowerCase())) {
  //               midiaType = "image";
  //             } else {
  //               midiaType = "video";
  //             }

  //             final fileName = "${DateTime.now()}${uuid}.jpg";
  //             final storageResponse = await supabase.storage
  //                 .from(SupabaseStorageConsts.midias)
  //                 .upload(fileName, imageFile);

  //             if (storageResponse.isNotEmpty) {
  //               final midiaPath = supabase.storage
  //                   .from(SupabaseStorageConsts.midias)
  //                   .getPublicUrl(fileName);

  //               final newMidia = CampaignMidiaModel(
  //                       id: uuid,
  //                       midiaType: midiaType,
  //                       midiaUrl: midiaPath,
  //                       campaignId: campaignId,
  //                       createdAt: DateTime.now(),
  //                       updatedAt: DateTime.now(),
  //                       userId: supabase.auth.currentUser!.id)
  //                   .toJson();

  //               await supabase.from(SupabaseConsts.midias).insert(newMidia);
  //             }
  //           });
  //         }
  //         if (campaign.documents!.length > 0) {
  //           campaign.documents!.forEach((element) async {
  //             final uuid = Uuid().v4();
  //             final documentFile = File(element.documentPath!);
  //             final fileExtension =
  //                 path.extension(documentFile.path).replaceFirst('.', '');

  //             final fileName = "${DateTime.now()}${uuid}.$fileExtension";
  //             final storageResponse = await supabase.storage
  //                 .from(SupabaseStorageConsts.documents)
  //                 .upload(fileName, documentFile);

  //             if (storageResponse.isNotEmpty) {
  //               final documentPath = supabase.storage
  //                   .from(SupabaseStorageConsts.documents)
  //                   .getPublicUrl(fileName);

  //               final newDocument = CampaignDocumentModel(
  //                       id: uuid,
  //                       documentPath: documentPath,
  //                       campaignId: campaignId,
  //                       createdAt: DateTime.now(),
  //                       updatedAt: DateTime.now(),
  //                       userId: supabase.auth.currentUser!.id)
  //                   .toJson();

  //               await supabase
  //                   .from(SupabaseConsts.documents)
  //                   .insert(newDocument);
  //             }
  //           });
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print("ERRORROROROR $e");
  //     throw e;
  //   }
  // }

  @override
  Future<void> deleteCampaign(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<CampaignEntity>> getAllCampaigns(
      {int? page = 1, int? limit = 10}) async {
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
  Future<List<CampaignEntity>> getAllUrgentCampaigns(
      {int? page = 1, int? limit = 10}) async {
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
  Future<List<CampaignEntity>> getLatestUrgentCampaigns(
      {int? page = 1, int? limit = 10}) async {
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
  Future<List<CampaignEntity>> getAllMyCampaigns(
      {int? page = 1, int? limit = 10}) async {
    final userId = supabase.auth.currentUser!.id;

    print("Page: $page");
    print("LIMIT: $limit");

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
    ''').eq('user_id', userId).order('created_at').range(page!, limit!);

    return response.map((event) => CampaignModel.fromJson(event)).toList();
  }
}
