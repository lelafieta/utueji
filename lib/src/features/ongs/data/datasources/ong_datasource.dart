import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    print('Ong Details:');
    print('Name: ${ong.name}');
    print('Bio: ${ong.bio}');
    print('About: ${ong.about}');
    print('Mission: ${ong.mission}');
    print('Vision: ${ong.vision}');
    print('Phone Number: ${ong.phoneNumber}');
    print('Email: ${ong.email}');
    print('Website: ${ong.website}');
    print('Profile Image URL: ${ong.profileImageUrl}');
    print('Cover Image URL: ${ong.coverImageUrl}');
    if (ong.ongDocument != null) {
      print('Ong Document Details:');
      print('Status: ${ong.ongDocument!.statutesConstitutiveAct}');
      print(
          'Declaration Good Standing: ${ong.ongDocument!.declarationGoodStanding}');
      print(
          'Minutes Constitutive Assembly: ${ong.ongDocument!.minutesConstitutiveAssembly}');
      print('Public Deed: ${ong.ongDocument!.publicDeed}');
      print(
          'Registration Certificate: ${ong.ongDocument!.registrationCertificate}');
      print('NIF: ${ong.ongDocument!.nif}');
      print('BI Representative: ${ong.ongDocument!.biRepresentative}');
    }
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) throw Exception("Usuário não autenticado");

      // Upload das imagens
      final profileImageUrl = ong.profileImageUrl != null
          ? await uploadFile(
              File(ong.profileImageUrl!),
              'images/${userId}_${DateTime.timestamp()}_profile.png',
              'ongprofile')
          : null;

      final coverImageUrl = ong.coverImageUrl != null
          ? await uploadFile(
              File(ong.coverImageUrl!),
              'images/${userId}_${DateTime.timestamp()}_cover.png',
              'ongprofile')
          : null;

      // Criar a ONG no Supabase
      final ongInsert = await supabase.from('ongs').insert({
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
      });
      // .select()
      // .single();

      print(ongInsert);

      // final ongId = ongInsert['id'];

      print("criado com sucesso");

      // // Upload dos documentos obrigatórios
      // final doc = ong.ongDocument!;
      // final statutesUrl = await uploadFile(
      //     File(doc.status!), 'documents/${userId}_statutes.pdf', 'ongdocs');
      // final declarationUrl = await uploadFile(
      //     File(doc.declarationGoodStanding!),
      //     'documents/${userId}_${DateTime.timestamp()}_declaration.pdf',
      //     'ongdocs');
      // final assemblyUrl = await uploadFile(
      //     File(doc.minutesConstitutiveAssembly!),
      //     'documents/${userId}_${DateTime.timestamp()}_assembly.pdf',
      //     'ongdocs');
      // final publicDeedUrl = await uploadFile(
      //     File(doc.publicDeed!),
      //     'documents/${userId}_${DateTime.timestamp()}_public_deed.pdf',
      //     'ongdocs');
      // final registrationUrl = doc.registrationCertificate != null
      //     ? await uploadFile(
      //         File(doc.registrationCertificate!),
      //         'documents/${userId}_${DateTime.timestamp()}_registration.pdf',
      //         'ongdocs')
      //     : null;
      // final nifUrl = await uploadFile(File(doc.nif!),
      //     'documents/${userId}_${DateTime.timestamp()}_nif.pdf', 'ongdocs');
      // final biUrl = await uploadFile(File(doc.biRepresentative!),
      //     'documents/${userId}_${DateTime.timestamp()}_bi.pdf', 'ongdocs');

      // // Inserir os documentos na tabela `ongs_documents`
      // await supabase.from('ongs_documents').insert({
      //   'user_id': userId,
      //   'ong_id': ongId,
      //   'statutes_constitutive_act': statutesUrl,
      //   'declaration_good_standing': declarationUrl,
      //   'minutes_constitutive_assembly': assemblyUrl,
      //   'public_deed': publicDeedUrl,
      //   'registration_certificate': registrationUrl,
      //   'nif': nifUrl,
      //   'bi_representative': biUrl,
      //   // 'status': 'pending',
      // });
      return unit;
    } catch (e) {
      print("BUGOU!!! $e");
      throw e;
    }
  }
}
