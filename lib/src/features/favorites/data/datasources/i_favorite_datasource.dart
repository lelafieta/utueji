import 'package:dartz/dartz.dart';
import '../models/favorite_model.dart';

abstract class IFavoriteDataSource {
  Future<Unit> addFavorite(FavoriteModel favorite);
  Future<Unit> removeFavorite(FavoriteModel favorite);
  Future<bool> isMyFavorite(String id);
  Stream<List<FavoriteModel>> getAllFavotires();
  Stream<List<FavoriteModel>> getFavoriteByType();
}
