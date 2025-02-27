import '../../../../core/usecases/stream_usecase.dart';
import '../entities/campaign_entity.dart';
import '../repositories/i_campaign_repository.dart';

class GetCampaignByIdUseCase extends StreamUseCase<CampaignEntity, String> {
  final ICampaignRepository repository;

  GetCampaignByIdUseCase({required this.repository});

  @override
  Stream<CampaignEntity> call(String params) {
    return repository.getCampaignById(params);
  }
}
