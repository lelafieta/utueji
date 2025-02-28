import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utueji/src/features/campaigns/presentation/cubit/campaign_favorite_cubit/campaign_favorite_state.dart';
import 'package:utueji/src/features/favorites/domain/entities/favorite_entity.dart';
import '../../../../favorites/domain/usecases/add_favorite_usecase.dart';
import '../../../../favorites/domain/usecases/remove_favorite_usecase.dart';
import '../../../domain/usecases/get_campaign_by_id_usecase.dart';
import 'campaign_detail_state.dart';

class CampaignDetailCubit extends Cubit<CampaignDetailState> {
  final GetCampaignByIdUseCase getCampaignByIdUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  CampaignDetailCubit({
    required this.getCampaignByIdUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
  }) : super(CampaignDetailInitial());

  Future<void> getCampaignById(String id) async {
    emit(CampaignDetailLoading());

    final response = getCampaignByIdUseCase.call(id);

    response.listen((campaign) {
      emit(CampaignDetailLoaded(campaign: campaign));
    });
  }

  Future<void> addFavorite(FavoriteEntity favorite) async {
    emit(CampaignDetailLoading());

    final response = await addFavoriteUseCase.call(favorite);

    response.fold(
        (l) => emit(CampaignDetailFailure(failure: l.toString())), (r) => emit);
  }
}
