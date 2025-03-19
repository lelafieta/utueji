import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/campaign_entity.dart';
import '../entities/campaign_params.dart';

abstract class ICampaignRepository {
  Future<Either<Failure, List<CampaignEntity>>> getAllCampaigns(
      CampaignParams params);
  Future<Either<Failure, List<CampaignEntity>>> getAllMyCampaigns(
      CampaignParams params);
  Future<Either<Failure, List<CampaignEntity>>> getAllUrgentCampaigns(
      CampaignParams params);
  Future<Either<Failure, List<CampaignEntity>>> getLatestUrgentCampaigns(
      CampaignParams params);
  Future<Either<Failure, CampaignEntity>> getCampaignById(String id);
  Future<Either<Failure, Unit>> createCampaign(CampaignEntity campaign);
  Future<Either<Failure, Unit>> updateCampaign(CampaignEntity campaign);
  Future<Either<Failure, Unit>> deleteCampaign(String id);
}
