import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../favorites/domain/usecases/is_my_favorite_usecase.dart';
import 'campaign_favorite_state.dart';

class CampaignFavoriteCubit extends Cubit<CampaignFavoriteState> {
  final IsMyFavoriteUseCase isMyFavoriteUseCase;

  CampaignFavoriteCubit({required this.isMyFavoriteUseCase})
      : super(CampaignFavoriteInitial());

  Future<void> isFavorited(String id) async {
    final response = await isMyFavoriteUseCase.call(id);

    response.fold((l) => emit(CampaignFavoriteFailure()),
        (r) => emit(CampaignFavoriteSuccess(isFavorited: r)));
  }
}
