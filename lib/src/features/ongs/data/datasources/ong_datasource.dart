import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/supabase/supabase_consts.dart';
import '../../domain/entities/ong_entity.dart';
import '../models/ong_model.dart';
import 'i_ong_datasource.dart';

class OngDataSource extends IOngDataSource {
  final SupabaseClient supabase;
  OngDataSource({required this.supabase});
  @override
  Stream<List<OngEntity>> fetchLatestOngs() {
    final ongs = supabase
        .from(SupabaseConsts.ongs)
        .select("*, user:profiles(*)")
        .order('created_at')
        .limit(10)
        .asStream()
        .map((data) {
      return data.map((ong) => OngModel.fromMap(ong)).toList();
    });

    return ongs;
  }

  Future<String?> uploadFile(File file, String path, String bdName) async {
    final storageResponse =
        await supabase.storage.from(bdName).upload(path, file);

    if (storageResponse.isEmpty) {
      print('Erro ao subir arquivo: ${storageResponse}');
      return null;
    }

    return supabase.storage.from(bdName).getPublicUrl(path);
  }

  @override
  Future<Unit> createOng(OngEntity ong) async {
    final uuid = Uuid().v4();

    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) throw Exception("Usuário não autenticado");

      // Upload das imagens (perfil e capa)
      final profileImageUrl = ong.profileImageUrl != null
          ? await uploadFile(
              File(ong.profileImageUrl!),
              'images/${userId}_${DateTime.timestamp()}_profile.png',
              'ongprofile',
            )
          : null;

      final coverImageUrl = ong.coverImageUrl != null
          ? await uploadFile(
              File(ong.coverImageUrl!),
              'images/${userId}_${DateTime.timestamp()}_cover.png',
              'ongprofile',
            )
          : null;

      // Upload dos documentos obrigatórios
      final doc = ong.ongDocument!;
      final statutesUrl = await uploadFile(File(doc.statutesConstitutiveAct!),
          'documents/${uuid}_${userId}_statutes.pdf', 'ongdocs');

      final declarationUrl = await uploadFile(
          File(doc.declarationGoodStanding!),
          'documents/${uuid}_${userId}_${DateTime.timestamp()}_declaration.pdf',
          'ongdocs');

      final assemblyUrl = await uploadFile(
          File(doc.minutesConstitutiveAssembly!),
          'documents/${uuid}_${userId}_${DateTime.timestamp()}_assembly.pdf',
          'ongdocs');

      final publicDeedUrl = await uploadFile(
          File(doc.publicDeed!),
          'documents/${uuid}_${userId}_${DateTime.timestamp()}_public_deed.pdf',
          'ongdocs');

      final registrationUrl = doc.registrationCertificate != null
          ? await uploadFile(
              File(doc.registrationCertificate!),
              'documents/${uuid}_${userId}_${DateTime.timestamp()}_registration.pdf',
              'ongdocs')
          : null;

      final nifUrl = await uploadFile(
          File(doc.nif!),
          'documents/${uuid}_${userId}_${DateTime.timestamp()}_nif.pdf',
          'ongdocs');

      final biUrl = await uploadFile(
          File(doc.biRepresentative!),
          'documents/${uuid}_${userId}_${DateTime.timestamp()}_bi.pdf',
          'ongdocs');

      // Chamada da stored procedure
      final result = await supabase.rpc('create_ong_with_documents', params: {
        'name': ong.name,
        'bio': ong.bio,
        'about': ong.about,
        'mission': ong.mission,
        'vision': ong.vision,
        'phone_number': ong.phoneNumber,
        'email': ong.email,
        'website': ong.website,
        'profile_image_url': profileImageUrl,
        'cover_image_url': coverImageUrl,
        'user_id': userId,
        'statutes_constitutive_act': statutesUrl,
        'declaration_good_standing': declarationUrl,
        'minutes_constitutive_assembly': assemblyUrl,
        'public_deed': publicDeedUrl,
        'registration_certificate': registrationUrl,
        'nif': nifUrl,
        'bi_representative': biUrl,
      });

      final ongId = result as String;
      print("ONG criada com sucesso: $ongId");

      return unit;
    } catch (e) {
      print("BUGOU!!! $e");
      throw e;
    }
  }
}
