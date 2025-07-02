import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/campaign_update_entity.dart';
import '../../../domain/usecases/create_campaign_update_usecase.dart';
import '../../../domain/usecases/delete_campaign_update_usecase.dart';
import '../../../domain/usecases/update_campaign_update_usecase.dart';
import 'update_action_state.dart';

class UpdateActionCubit extends Cubit<UpdateActionState> {
  final CreateCampaignUpdateUseCase createCampaignUpdateUseCase;
  final UpdateCampaignUpdateUseCase updateCampaignUpdateUseCase;
  final DeleteCampaignUpdateUseCase deleteCampaignUpdateUseCase;

  UpdateActionCubit({
    required this.createCampaignUpdateUseCase,
    required this.updateCampaignUpdateUseCase,
    required this.deleteCampaignUpdateUseCase,
  }) : super(UpdateActionInitial());

  Future<void> create(CampaignUpdateEntity params) async {
    emit(UpdateActionLoading());
    final result = await createCampaignUpdateUseCase.call(params);

    result.fold((l) => emit(UpdateActionFailure(message: l.message.toString())),
        (r) => emit(UpdateActionSuccess()));
  }
}
