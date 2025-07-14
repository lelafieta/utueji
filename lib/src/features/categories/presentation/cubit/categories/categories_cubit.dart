import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utueji/src/core/entities/no_params.dart';
import 'package:utueji/src/features/categories/domain/params/create_category_params.dart';
import 'package:utueji/src/features/categories/domain/params/update_category_params.dart';
import 'package:utueji/src/features/categories/domain/usecases/create_category_usecase.dart';
import 'package:utueji/src/features/categories/domain/usecases/delete_category_usecase.dart';
import 'package:utueji/src/features/categories/domain/usecases/get_all_categories_usecase.dart';
import 'package:utueji/src/features/categories/domain/usecases/get_category_by_id_usecase.dart';
import 'package:utueji/src/features/categories/domain/usecases/update_category_usecase.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CreateCategoryUseCase createCategoryUseCase;
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetCategoryByIdUseCase getCategoryByIdUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  CategoriesCubit({
    required this.createCategoryUseCase,
    required this.getAllCategoriesUseCase,
    required this.getCategoryByIdUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
  }) : super(CategoriesInitial());

  Future<void> createCategory(CreateCategoryParams params) async {
    emit(CategoriesLoading());
    final result = await createCategoryUseCase(params);
    result.fold(
      (failure) => emit(CategoriesError(message: failure.toString())),
      (category) => emit(
        const CategoriesSuccess(categories: []),
      ), // Refresh all categories after creation
    );
  }

  Future<void> getAllCategories() async {
    emit(CategoriesLoading());
    final result = await getAllCategoriesUseCase(const NoParams());
    result.fold(
      (failure) => emit(CategoriesError(message: failure.toString())),
      (categories) => emit(CategoriesSuccess(categories: categories)),
    );
  }

  Future<void> getCategoryById(int id) async {
    emit(CategoriesLoading());
    final result = await getCategoryByIdUseCase(id);
    result.fold(
      (failure) => emit(CategoriesError(message: failure.toString())),
      (category) => emit(
        CategoriesSuccess(categories: [category]),
      ), // Return single category in a list
    );
  }

  Future<void> updateCategory(UpdateCategoryParams params) async {
    emit(CategoriesLoading());
    final result = await updateCategoryUseCase(params);
    result.fold(
      (failure) => emit(CategoriesError(message: failure.toString())),
      (category) => emit(
        const CategoriesSuccess(categories: []),
      ), // Refresh all categories after update
    );
  }

  Future<void> deleteCategory(int id) async {
    emit(CategoriesLoading());
    final result = await deleteCategoryUseCase(id);
    result.fold(
      (failure) => emit(CategoriesError(message: failure.toString())),
      (_) => emit(
        const CategoriesSuccess(categories: []),
      ), // Refresh all categories after deletion
    );
  }
}
