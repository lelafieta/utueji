import 'package:bloc/bloc.dart';

import '../../../../../core/entities/no_params.dart';
import '../../../domain/usecases/get_all_my_campaigns_usecase.dart';
import 'my_campaign_state.dart';

class MyCampaignCubit extends Cubit<MyCampaignState> {
  final GetAllMyCampaignsUseCase getAllMyCampaignsUseCase;

  MyCampaignCubit({required this.getAllMyCampaignsUseCase})
      : super(MyCampaignInitial());

  Future<void> getAllMyCamapigns() async {
    emit(MyCampaignLoading());
    final result = await getAllMyCampaignsUseCase.call(const NoParams());

    result.fold(
        (failure) => emit(MyCampaignError(message: failure.message.toString())),
        (campaigns) => emit(MyCampaignLoaded(campaigns: campaigns)));
  }
}
