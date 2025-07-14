import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/category_entity.dart';
import '../params/update_category_params.dart';
import '../repositories/i_category_repository.dart';

class UpdateCategoryUseCase extends BaseUseCase<CategoryEntity, UpdateCategoryParams> {
  final ICategoryRepository repository;

  UpdateCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, CategoryEntity>> call(UpdateCategoryParams params) async {
    return await repository.updateCategory(params);
  }
}
