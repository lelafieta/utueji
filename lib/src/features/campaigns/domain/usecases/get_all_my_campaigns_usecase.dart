import 'package:dartz/dartz.dart';

import '../../../../core/entities/no_params.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/campaign_entity.dart';
import '../repositories/i_campaign_repository.dart';

class GetAllMyCampaignsUseCase
    extends BaseUseCase<List<CampaignEntity>, NoParams> {
  final ICampaignRepository repository;

  GetAllMyCampaignsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CampaignEntity>>> call(NoParams params) async {
    return await repository.getAllMyCampaigns();
  }
}
