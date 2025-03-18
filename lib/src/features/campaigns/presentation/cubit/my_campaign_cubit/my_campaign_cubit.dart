import 'package:bloc/bloc.dart';
import 'package:utueji/src/features/campaigns/domain/entities/campaign_params.dart';
import '../../../domain/entities/campaign_entity.dart';
import '../../../domain/usecases/get_all_my_campaigns_usecase.dart';
import 'my_campaign_state.dart';

class MyCampaignCubit extends Cubit<MyCampaignState> {
  final GetAllMyCampaignsUseCase getAllMyCampaignsUseCase;

  MyCampaignCubit({required this.getAllMyCampaignsUseCase})
      : super(MyCampaignInitial());

  int page = 1;

  Future<void> getAllMyCamapigns(
      {required int pagea, required int limit}) async {
    if (state is MyCampaignLoading) return;

    final currentState = state;

    var oldCampaigns = <CampaignEntity>[];

    if (currentState is MyCampaignLoaded) {
      oldCampaigns = currentState.campaigns;
    }

    emit(MyCampaignLoading(oldCampaigns, isFirstFetch: page == 1));
    final result = await getAllMyCampaignsUseCase
        .call(CampaignParams(page: page, limit: limit));

    result.fold(
        (failure) => emit(MyCampaignError(message: failure.message.toString())),
        (myCampaigns) {
      page++;
      final campaigns = (state as MyCampaignLoading).oldCampaigns;
      campaigns.addAll(myCampaigns);
      emit(MyCampaignLoaded(campaigns: campaigns, isLastPage: false));
    });
  }
}
