import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/campaign_entity.dart';
import '../repositories/i_campaign_repository.dart';

class UpdateCampaignUseCase extends BaseUseCase<Unit, CampaignEntity> {
  final ICampaignRepository repository;
  UpdateCampaignUseCase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(CampaignEntity params) async {
    return await repository.updateCampaign(params);
  }
}
