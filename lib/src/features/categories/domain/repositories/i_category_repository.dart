import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/category_entity.dart';
import '../params/create_category_params.dart';
import '../params/update_category_params.dart';

abstract class ICategoryRepository {
  Future<Either<Failure, CategoryEntity>> createCategory(CreateCategoryParams params);
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();
  Future<Either<Failure, CategoryEntity>> getCategoryById(int id);
  Future<Either<Failure, CategoryEntity>> updateCategory(UpdateCategoryParams params);
  Future<Either<Failure, void>> deleteCategory(int id);
}
