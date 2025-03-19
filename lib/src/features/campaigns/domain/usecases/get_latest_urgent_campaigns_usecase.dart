import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/campaign_entity.dart';
import '../entities/campaign_params.dart';
import '../repositories/i_campaign_repository.dart';

class GetLatestUrgentCampaignsUseCase
    extends BaseUseCase<List<CampaignEntity>, CampaignParams> {
  final ICampaignRepository repository;

  GetLatestUrgentCampaignsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CampaignEntity>>> call(
      CampaignParams params) async {
    return await repository.getLatestUrgentCampaigns(params);
  }
}
