import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/favorite_entity.dart';
import '../repositories/i_favorite_repository.dart';

class RemoveFavoriteUseCase extends BaseUseCase<Unit, FavoriteEntity> {
  final IFavoriteRepository repository;

  RemoveFavoriteUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(FavoriteEntity params) async {
    return await repository.removeFavorite(params);
  }
}
