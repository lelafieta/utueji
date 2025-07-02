import 'package:dartz/dartz.dart';

import '../models/campaign_update_model.dart';

abstract class IUpdateDataSource {
  Future<Unit> create(CampaignUpdateModel update);
  Future<Unit> update(CampaignUpdateModel update);
  Future<Unit> delete(String id);
  Future<List<CampaignUpdateModel>> listCampaignUpdates(String id);
}
