import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/campaign_entity.dart';

abstract class ICampaignRepository {
  Future<Either<Failure, List<CampaignEntity>>> getAllCampaigns();
  Future<Either<Failure, List<CampaignEntity>>> getAllMyCampaigns();
  Future<Either<Failure, List<CampaignEntity>>> getAllUrgentCampaigns();
  Future<Either<Failure, List<CampaignEntity>>> getLatestUrgentCampaigns();
  Future<Either<Failure, CampaignEntity>> getCampaignById(String id);
  Future<Either<Failure, Unit>> createCampaign(CampaignEntity campaign);
  Future<Either<Failure, Unit>> updateCampaign(CampaignEntity campaign);
  Future<Either<Failure, Unit>> deleteCampaign(String id);
}
