import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../repositories/i_favorite_repository.dart';

class RemoveFavoriteUseCase extends BaseUseCase<Unit, String> {
  final IFavoriteRepository repository;

  RemoveFavoriteUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(String params) async {
    return await repository.removeFavorite(params);
  }
}
