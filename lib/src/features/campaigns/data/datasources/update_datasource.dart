import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/campaign_update_model.dart';
import 'i_update_datasource.dart';

class UpdateDataSource extends IUpdateDataSource {
  final SupabaseClient supabase;

  UpdateDataSource({required this.supabase});

  @override
  Future<Unit> create(CampaignUpdateModel update) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Unit> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CampaignUpdateModel>> listCampaignUpdates(String id) {
    // TODO: implement listCampaignUpdates
    throw UnimplementedError();
  }

  @override
  Future<Unit> update(CampaignUpdateModel update) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
