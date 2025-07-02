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
  int limit = 10;
  Future<void> getAllMyCamapigns(
      {bool isRefresh = false, CampaignParams? params}) async {
    print(params!.status);
    if (state is MyCampaignLoading) return;

    if (isRefresh) {
      page = 1;
      emit(MyCampaignInitial());
    }

    final currentState = state;
    var oldCampaigns = <CampaignEntity>[];

    if (currentState is MyCampaignLoaded && !isRefresh) {
      oldCampaigns = currentState.campaigns;
    }

    emit(MyCampaignLoading(oldCampaigns, isFirstFetch: page == 1));

    final result = await getAllMyCampaignsUseCase.call(CampaignParams(
        page: page, limit: limit, status: params.status, title: params.title));

    result.fold(
      (failure) => emit(MyCampaignError(message: failure.message.toString())),
      (myCampaigns) {
        if (isRefresh) {
          oldCampaigns.clear();
        }

        if (myCampaigns.isEmpty) {
          emit(MyCampaignLoaded(campaigns: oldCampaigns, isLastPage: true));
        } else {
          page++;
          final campaigns = (state as MyCampaignLoading).oldCampaigns;
          campaigns.addAll(myCampaigns);
          emit(MyCampaignLoaded(campaigns: campaigns, isLastPage: false));
        }
      },
    );
  }
}
