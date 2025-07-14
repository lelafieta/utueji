import 'package:dartz/dartz.dart';

import '../../../../core/entities/no_params.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/category_entity.dart';
import '../repositories/i_category_repository.dart';

class GetAllCategoriesUseCase extends BaseUseCase<List<CategoryEntity>, NoParams> {
  final ICategoryRepository repository;

  GetAllCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) async {
    return await repository.getAllCategories();
  }
}
