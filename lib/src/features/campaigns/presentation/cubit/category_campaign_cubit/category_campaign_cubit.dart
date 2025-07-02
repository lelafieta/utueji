import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/campaign_entity.dart';
import '../../../domain/entities/campaign_params.dart';

import '../../../domain/usecases/get_all_campaigns_usecase.dart';
import 'category_campaign_state.dart';

class CategoryCampaignCubit extends Cubit<CategoryCampaignState> {
  final GetAllCampaignsUseCase getAllCampaignsUseCase;
  CategoryCampaignCubit({
    required this.getAllCampaignsUseCase,
  }) : super(CategoryCampaignInitial());

  int page = 1;
  int limit = 10;

  Future<void> getAllCategoryCampaigns(
      {bool isRefresh = false, CampaignParams? params}) async {
    if (state is CategoryCampaignLoading) return;

    if (isRefresh) {
      page = 1;
      emit(CategoryCampaignInitial());
    }

    final currentState = state;
    var oldCampaigns = <CampaignEntity>[];

    if (currentState is CategoryCampaignLoaded && !isRefresh) {
      oldCampaigns = currentState.campaigns;
    }

    emit(CategoryCampaignLoading(oldCampaigns, isFirstFetch: page == 1));

    final result = await getAllCampaignsUseCase.call(CampaignParams(
        page: page,
        limit: limit,
        status: params!.status,
        title: params.title,
        filter: params.filter,
        categoryId: params.categoryId));

    result.fold(
      (failure) =>
          emit(CategoryCampaignError(message: failure.message.toString())),
      (myCampaigns) {
        if (isRefresh) {
          oldCampaigns.clear();
        }

        if (myCampaigns.isEmpty) {
          emit(CategoryCampaignLoaded(
              campaigns: oldCampaigns, isLastPage: true));
        } else {
          page++;
          final campaigns = (state as CategoryCampaignLoading).oldCampaigns;
          campaigns.addAll(myCampaigns);
          emit(CategoryCampaignLoaded(
            campaigns: campaigns,
            isLastPage: false,
          ));
        }
      },
    );
  }
}
