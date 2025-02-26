import '../../../../core/entities/no_params.dart';
import '../../../../core/usecases/stream_usecase.dart';
import '../entities/campaign_entity.dart';
import '../repositories/i_campaign_repository.dart';

class GetCampaignsUseCase
    extends StreamUseCase<List<CampaignEntity>, NoParams> {
  final ICampaignRepository repository;

  GetCampaignsUseCase({required this.repository});

  @override
  Stream<List<CampaignEntity>> call(NoParams params) {
    return repository.getCampaigns();
  }
}
