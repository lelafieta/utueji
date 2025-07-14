import 'package:dartz/dartz.dart';
import 'package:utueji/src/core/errors/server_failure.dart';
import 'package:utueji/src/core/network/i_network_info.dart';
import 'package:utueji/src/features/categories/data/dto/create_category_dto.dart';
import 'package:utueji/src/features/categories/data/dto/update_category_dto.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/params/create_category_params.dart';
import '../../domain/params/update_category_params.dart';
import '../../domain/repositories/i_category_repository.dart';
import '../datasources/category_remote_datasource.dart';

class CategoryRepository implements ICategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final INetWorkInfo networkInfo;

  CategoryRepository({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CategoryEntity>> createCategory(CreateCategoryParams params) async {
    try {
      final categoryModel = await remoteDataSource.createCategory(
        CreateCategoryDto(name: params.name),
      );
      return Right(categoryModel);
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      final categories = await remoteDataSource.getAllCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategoryById(int id) async {
    try {
      final category = await remoteDataSource.getCategoryById(id);
      return Right(category);
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> updateCategory(UpdateCategoryParams params) async {
    try {
      final categoryModel = await remoteDataSource.updateCategory(
        params.id,
        UpdateCategoryDto(name: params.name),
      );
      return Right(categoryModel);
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(int id) async {
    try {
      await remoteDataSource.deleteCategory(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }
}
