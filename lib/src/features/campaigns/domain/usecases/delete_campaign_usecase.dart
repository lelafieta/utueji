import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../repositories/i_campaign_repository.dart';

class DeleteCampaignUseCase extends BaseUseCase<Unit, String> {
  final ICampaignRepository repository;

  DeleteCampaignUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(String params) async {
    return await repository.deleteCampaign(params);
  }
}
