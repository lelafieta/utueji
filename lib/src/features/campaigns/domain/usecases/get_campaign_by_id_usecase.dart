import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/campaign_entity.dart';
import '../repositories/i_campaign_repository.dart';

class GetCampaignByIdUseCase extends BaseUseCase<CampaignEntity, String> {
  final ICampaignRepository repository;

  GetCampaignByIdUseCase({required this.repository});

  @override
  Future<Either<Failure, CampaignEntity>> call(String params) async {
    return await repository.getCampaignById(params);
  }
}
