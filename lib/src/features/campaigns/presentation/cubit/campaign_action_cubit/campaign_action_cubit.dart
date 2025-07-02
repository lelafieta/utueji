import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:utueji/src/features/campaigns/domain/entities/campaign_entity.dart';
import 'package:utueji/src/features/campaigns/domain/usecases/create_campaign_usecase.dart';
import 'package:utueji/src/features/campaigns/domain/usecases/update_campaign_usecase.dart';

part 'campaign_action_state.dart';

class CampaignActionCubit extends Cubit<CampaignActionState> {
  final CreateCampaignUseCase createCampaignUseCase;
  final UpdateCampaignUseCase updateCampaignUseCase;

  CampaignActionCubit(
      {required this.createCampaignUseCase,
      required this.updateCampaignUseCase})
      : super(CampaignActionInitial());

  Future<void> create(CampaignEntity params) async {
    emit(CampaignActionLoading());
    final result = await createCampaignUseCase.call(params);

    result.fold(
        (failure) =>
            emit(CampaignActionError(message: failure.message.toString())),
        (success) => emit(CampaignActionSuccess()));
  }

  Future<void> update(CampaignEntity params) async {
    emit(CampaignActionLoading());
    final result = await updateCampaignUseCase.call(params);

    result.fold(
        (failure) =>
            emit(CampaignActionError(message: failure.message.toString())),
        (success) => emit(CampaignActionSuccess()));
  }
}
