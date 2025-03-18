import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/campaign_entity.dart';

abstract class ICampaignRepository {
  Future<Either<Failure, List<CampaignEntity>>> getAllCampaigns(
      {required int page, required int limit});
  Future<Either<Failure, List<CampaignEntity>>> getAllMyCampaigns(
      {required int page, required int limit});
  Future<Either<Failure, List<CampaignEntity>>> getAllUrgentCampaigns(
      {required int page, required int limit});
  Future<Either<Failure, List<CampaignEntity>>> getLatestUrgentCampaigns(
      {required int page, required int limit});
  Future<Either<Failure, CampaignEntity>> getCampaignById(String id);
  Future<Either<Failure, Unit>> createCampaign(CampaignEntity campaign);
  Future<Either<Failure, Unit>> updateCampaign(CampaignEntity campaign);
  Future<Either<Failure, Unit>> deleteCampaign(String id);
}
