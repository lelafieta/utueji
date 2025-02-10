import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_campaigns_usecases.dart';
import '../../domain/usecases/get_latest_campaigns_usecases.dart';
import 'campaign_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  final GetCampaignsUseCase getCampaignsUseCase;
  final GetLatestCampaignsUseCase getLatestCampaignsUseCase;
  CampaignCubit({
    required this.getCampaignsUseCase,
    required this.getLatestCampaignsUseCase,
  }) : super(CampaignInitial());

  Future<void> getCampaigns() async {
    emit(CampaignLoading());

    final campaigns = getCampaignsUseCase.call();

    campaigns.listen((event) {
      emit(CampaignLoaded(campaigns: event));
    });
  }

  Future<void> getLatestCampaigns() async {
    emit(CampaignLoading());

    final campaigns = getLatestCampaignsUseCase.call();

    campaigns.listen((event) {
      emit(CampaignLoaded(campaigns: event));
    });
  }
}
