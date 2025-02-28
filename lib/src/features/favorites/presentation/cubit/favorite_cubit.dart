import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utueji/src/features/favorites/domain/usecases/get_all_favorites_usecase.dart';

import '../../../../core/entities/no_params.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final GetAllFavoritesByUseCase getAllFavoritesByUseCase;

  FavoriteCubit({required this.getAllFavoritesByUseCase})
      : super(FavoriteInitial());

  Future<void> getAllFavorites() async {
    emit(FavoriteLoading());
    final response = getAllFavoritesByUseCase.call(const NoParams());

    response.listen((favorites) {
      emit(FavoriteLoaded(favorites: favorites));
    });
  }
}
