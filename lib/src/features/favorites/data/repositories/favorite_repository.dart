import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/favorite_entity.dart';
import '../../domain/repositories/i_favorite_repository.dart';
import '../datasources/i_favorite_datasource.dart';

class FavoriteRepository extends IFavoriteRepository {
  final IFavoriteDataSource datasource;

  FavoriteRepository({required this.datasource});
  @override
  Future<Either<Failure, Unit>> addFavorite(FavoriteEntity favorite) {
    // TODO: implement addFavorite
    throw UnimplementedError();
  }

  @override
  Stream<List<FavoriteEntity>> getAllFavotires() {
    return datasource.getAllFavotires();
  }

  @override
  Stream<List<FavoriteEntity>> getFavoriteByType() {
    // TODO: implement getFavoriteByType
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> isMyFavorite(String id) async {
    try {
      final response = await datasource.isMyFavorite(id);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFavorite(String id) {
    // TODO: implement removeFavorite
    throw UnimplementedError();
  }
}
