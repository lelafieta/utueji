import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../repositories/i_favorite_repository.dart';

class IsMyFavoriteUseCase extends BaseUseCase<bool, String> {
  final IFavoriteRepository repository;

  IsMyFavoriteUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.isMyFavorite(params);
  }
}
