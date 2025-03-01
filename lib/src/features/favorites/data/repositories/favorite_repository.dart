import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/favorite_entity.dart';
import '../../domain/repositories/i_favorite_repository.dart';
import '../datasources/i_favorite_datasource.dart';
import '../models/favorite_model.dart';

class FavoriteRepository extends IFavoriteRepository {
  final IFavoriteDataSource datasource;

  FavoriteRepository({required this.datasource});
  @override
  Future<Either<Failure, Unit>> addFavorite(FavoriteEntity favorite) async {
    try {
      final response =
          await datasource.addFavorite(FavoriteModel.fromEntity(favorite));
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
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
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFavorite(FavoriteEntity favorite) async {
    print(favorite);
    try {
      final response =
          await datasource.removeFavorite(FavoriteModel.fromEntity(favorite));
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
