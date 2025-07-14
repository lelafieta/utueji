import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../repositories/i_category_repository.dart';

class DeleteCategoryUseCase extends BaseUseCase<void, int> {
  final ICategoryRepository repository;

  DeleteCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteCategory(id);
  }
}
