import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/campaign_update_entity.dart';

abstract class IUpdateRepository {
  Future<Either<Failure, Unit>> create(CampaignUpdateEntity update);
  Future<Either<Failure, Unit>> update(CampaignUpdateEntity update);
  Future<Either<Failure, Unit>> delete(String id);
  Future<Either<Failure, List<CampaignUpdateEntity>>> listCampaignUpdates(
      String id);
}
