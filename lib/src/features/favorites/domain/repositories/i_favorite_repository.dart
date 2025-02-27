import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/favorite_entity.dart';

abstract class IFavoriteRepository {
  Future<Either<Failure, Unit>> addFavorite(FavoriteEntity favorite);
  Future<Either<Failure, Unit>> removeFavorite(String id);
  Future<Either<Failure, bool>> isMyFavorite(String id);
  Stream<List<FavoriteEntity>> getAllFavotires();
  Stream<List<FavoriteEntity>> getFavoriteByType();
}
