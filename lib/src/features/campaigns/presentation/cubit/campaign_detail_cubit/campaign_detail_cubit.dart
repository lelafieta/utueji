import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_campaign_by_id_usecase.dart';
import 'campaign_detail_state.dart';

class CampaignDetailCubit extends Cubit<CampaignDetailState> {
  final GetCampaignByIdUseCase getCampaignByIdUseCase;
  CampaignDetailCubit({
    required this.getCampaignByIdUseCase,
  }) : super(CampaignDetailInitial());

  Future<void> getCampaignById(String id) async {
    emit(CampaignDetailLoading());

    final response = getCampaignByIdUseCase.call(id);

    response.listen((campaign) {
      emit(CampaignDetailLoaded(campaign: campaign));
    });
  }
}
