import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utueji/src/features/campaigns/domain/entities/campaign_params.dart';
import '../../../../../core/entities/no_params.dart';
import '../../../../campaigns/domain/usecases/get_latest_urgent_campaigns_usecase.dart';
import 'home_campaign_state.dart';

class HomeCampaignCubit extends Cubit<HomeCampaignState> {
  final GetLatestUrgentCampaignsUseCase getLatestUrgentCampaignsUseCase;
  HomeCampaignCubit({
    required this.getLatestUrgentCampaignsUseCase,
  }) : super(HomeCampaignInitial());

  Future<void> getLatestUrgentCampaigns() async {
    emit(HomeCampaignLoading());

    final response = await getLatestUrgentCampaignsUseCase
        .call(CampaignParams(page: 1, limit: 10));

    response.fold(
        (failure) =>
            emit(HomeCampaignError(message: failure.message.toString())),
        (campaigns) => emit(HomeCampaignLoaded(campaigns: campaigns)));
  }
}
