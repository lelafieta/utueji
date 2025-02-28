import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../favorites/domain/entities/favorite_entity.dart';
import '../../../../favorites/domain/usecases/add_favorite_usecase.dart';
import '../../../../favorites/domain/usecases/remove_favorite_usecase.dart';

enum CampaignStoreFavoriteState { initial, loading, success, error }

class CampaignStoreFavoriteCubit extends Cubit<CampaignStoreFavoriteState> {
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  CampaignStoreFavoriteCubit({
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
  }) : super(CampaignStoreFavoriteState.initial);

  Future<void> addFavorite(FavoriteEntity favorite) async {
    emit(CampaignStoreFavoriteState.loading);

    final response = await addFavoriteUseCase.call(favorite);

    response.fold((l) => emit(CampaignStoreFavoriteState.error),
        (r) => emit(CampaignStoreFavoriteState.success));
  }

  Future<void> removeFavorite(FavoriteEntity params) async {
    emit(CampaignStoreFavoriteState.loading);

    final response = await removeFavoriteUseCase.call(params);

    response.fold((l) => emit(CampaignStoreFavoriteState.error),
        (r) => emit(CampaignStoreFavoriteState.success));
  }
}
