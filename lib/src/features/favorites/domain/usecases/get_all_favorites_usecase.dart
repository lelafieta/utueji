import 'package:dartz/dartz.dart';
import '../../../../core/entities/no_params.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../../../../core/usecases/stream_usecase.dart';
import '../entities/favorite_entity.dart';
import '../repositories/i_favorite_repository.dart';

class GetAllFavoritesByUseCase
    extends StreamUseCase<List<FavoriteEntity>, NoParams> {
  final IFavoriteRepository repository;

  GetAllFavoritesByUseCase({required this.repository});

  @override
  Stream<List<FavoriteEntity>> call(NoParams params) {
    return repository.getAllFavotires();
  }
}
