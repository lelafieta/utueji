import 'package:dartz/dartz.dart';
import '../models/favorite_model.dart';

abstract class IFavoriteDataSource {
  Future<Unit> addFavorite(FavoriteModel favorite);
  Future<Unit> removeFavorite(String id);
  Future<bool> isMyFavorite(String id);
  Stream<List<FavoriteModel>> getAllFavotires();
  Stream<List<FavoriteModel>> getFavoriteByType();
}
