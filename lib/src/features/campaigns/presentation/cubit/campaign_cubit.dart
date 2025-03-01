import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/entities/no_params.dart';
import '../../domain/usecases/get_campaigns_usecase.dart';
import '../../domain/usecases/get_latest_urgent_campaigns_usecase.dart';
import 'campaign_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  final GetCampaignsUseCase getCampaignsUseCase;
  final GetLatestUrgentCampaignsUseCase getLatestUrgentCampaignsUseCase;
  CampaignCubit({
    required this.getCampaignsUseCase,
    required this.getLatestUrgentCampaignsUseCase,
  }) : super(CampaignInitial());

  Future<void> getCampaigns() async {
    emit(CampaignLoading());

    final campaigns = getCampaignsUseCase.call(const NoParams());

    campaigns.listen((event) {
      emit(CampaignLoaded(campaigns: event));
    });
  }

  Future<void> getLatestUrgentCampaigns() async {
    emit(CampaignLoading());

    final campaigns = getLatestUrgentCampaignsUseCase.call();

    campaigns.listen((event) {
      emit(CampaignLoaded(campaigns: event));
    });
    // SupabaseClient supabase = Supabase.instance.client;
    // supabase.from('campaigns').stream(primaryKey: ['id']).listen((event) {
    // print("ACTUALIZANDO...");
    // print(CampaignModel.fromJson(event[0]).fundsRaised);
    //   emit(CampaignLoaded(
    //       campaigns: event.map((e) => CampaignModel.fromJson(e)).toList()));
    // });
  }
}
