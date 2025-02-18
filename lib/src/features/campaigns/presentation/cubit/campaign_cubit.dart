import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/campaign_model.dart';
import '../../domain/usecases/get_campaigns_usecases.dart';
import '../../domain/usecases/get_latest_campaigns_usecases.dart';
import 'campaign_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  final GetCampaignsUseCase getCampaignsUseCase;
  final GetLatestCampaignsUseCase getLatestCampaignsUseCase;
  CampaignCubit({
    required this.getCampaignsUseCase,
    required this.getLatestCampaignsUseCase,
  }) : super(CampaignInitial());

  Future<void> getCampaigns() async {
    emit(CampaignLoading());

    final campaigns = getCampaignsUseCase.call();

    campaigns.listen((event) {
      emit(CampaignLoaded(campaigns: event));
    });
  }

  Future<void> getLatestCampaigns() async {
    emit(CampaignLoading());

    final campaigns = getLatestCampaignsUseCase.call();

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
