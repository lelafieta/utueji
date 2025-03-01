import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/entities/no_params.dart';
import '../../domain/entities/campaign_entity.dart';
import '../../domain/usecases/get_all_campaigns_usecase.dart';

part 'campaign_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  final GetAllCampaignsUseCase getAllCampaignsUseCase;

  CampaignCubit({required this.getAllCampaignsUseCase})
      : super(CampaignInitial());

  Future<void> getAllCamapigns() async {
    emit(CampaignLoading());
    final result = await getAllCampaignsUseCase.call(const NoParams());

    result.fold(
        (failure) => emit(CampaignError(message: failure.message.toString())),
        (campaigns) => emit(CampaignLoaded(campaigns: campaigns)));
  }
}
