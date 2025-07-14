import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/category_entity.dart';
import '../repositories/i_category_repository.dart';

class GetCategoryByIdUseCase extends BaseUseCase<CategoryEntity, int> {
  final ICategoryRepository repository;

  GetCategoryByIdUseCase(this.repository);

  @override
  Future<Either<Failure, CategoryEntity>> call(int id) async {
    return await repository.getCategoryById(id);
  }
}
