import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_all_urgent_campaigns_usecase.dart';
import 'campaign_urgent_state.dart';

class CampaignUrgentCubit extends Cubit<CampaignUrgentState> {
  final GetAllUrgentCampaignsUseCase getUrgentCampaignsUseCase;
  CampaignUrgentCubit({
    required this.getUrgentCampaignsUseCase,
  }) : super(CampaignUrgentInitial());

  Future<void> getUrgentCampaigns() async {
    emit(CampaignUrgentLoading());
    // final response = await getUrgentCampaignsUseCase.call();

    // response.fold(
    //     (failure) =>
    //         emit(CampaignUrgentError(message: failure.message.toString())),
    //     (campaigns) => emit(CampaignUrgentLoaded(campaigns: campaigns)));
  }
}
