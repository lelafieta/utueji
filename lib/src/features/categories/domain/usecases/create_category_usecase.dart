import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/category_entity.dart';
import '../params/create_category_params.dart';
import '../repositories/i_category_repository.dart';

class CreateCategoryUseCase extends BaseUseCase<CategoryEntity, CreateCategoryParams> {
  final ICategoryRepository repository;

  CreateCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, CategoryEntity>> call(CreateCategoryParams params) async {
    return await repository.createCategory(params);
  }
}
