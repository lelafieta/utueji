import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/entities/no_params.dart';
import '../../../../favorites/domain/usecases/get_all_favorites_usecase.dart';
import '../../../../favorites/domain/usecases/is_my_favorite_usecase.dart';
import 'campaign_favorite_state.dart';

class CampaignFavoriteCubit extends Cubit<CampaignFavoriteState> {
  final IsMyFavoriteUseCase isMyFavoriteUseCase;
  final GetAllFavoritesByUseCase getAllFavoritesByUseCase;

  CampaignFavoriteCubit({
    required this.isMyFavoriteUseCase,
    required this.getAllFavoritesByUseCase,
  }) : super(CampaignFavoriteInitial());

  Future<void> isFavorited(String id) async {
    emit(CampaignFavoriteLoading());
    final response = await isMyFavoriteUseCase.call(id);

    response.fold((l) => emit(CampaignFavoriteFailure()),
        (r) => emit(CampaignFavoriteSuccess(isFavorited: r)));
  }

  Future<void> getAllFavorites() async {
    emit(CampaignFavoriteLoading());
    final response = getAllFavoritesByUseCase.call(const NoParams());

    response.listen((event) {
      print("ARRASY ${event.length}");
      emit(CampaignFavoriteLoaded(favorites: event));
    });
  }
}
