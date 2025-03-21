import 'package:bloc/bloc.dart';

import '../../domain/entities/campaign_entity.dart';
import '../../domain/entities/campaign_params.dart';
import '../../domain/usecases/get_all_campaigns_usecase.dart';
import 'campaign_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  final GetAllCampaignsUseCase getAllCampaignsUseCase;

  CampaignCubit({required this.getAllCampaignsUseCase})
      : super(CampaignInitial());

  int page = 1;
  int limit = 10;
  Future<void> getAllMyCamapigns(
      {bool isRefresh = false, CampaignParams? params}) async {
    print(params!.status);
    if (state is CampaignLoading) return;

    if (isRefresh) {
      page = 1;
      emit(CampaignInitial());
    }

    final currentState = state;
    var oldCampaigns = <CampaignEntity>[];

    if (currentState is CampaignLoaded && !isRefresh) {
      oldCampaigns = currentState.campaigns;
    }

    emit(CampaignLoading(oldCampaigns, isFirstFetch: page == 1));

    final result = await getAllCampaignsUseCase.call(CampaignParams(
        page: page, limit: limit, status: params.status, title: params.title));

    result.fold(
      (failure) => emit(CampaignError(message: failure.message.toString())),
      (myCampaigns) {
        if (isRefresh) {
          oldCampaigns.clear();
        }

        if (myCampaigns.isEmpty) {
          emit(CampaignLoaded(campaigns: oldCampaigns, isLastPage: true));
        } else {
          page++;
          final campaigns = (state as CampaignLoading).oldCampaigns;
          campaigns.addAll(myCampaigns);
          emit(CampaignLoaded(campaigns: campaigns, isLastPage: false));
        }
      },
    );
  }
}
