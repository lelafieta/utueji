import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utueji/src/features/categories/domain/entities/category_entity.dart';
import 'package:utueji/src/features/categories/domain/usecases/get_category_by_id_usecase.dart';

import 'package:utueji/src/features/categories/presentation/cubit/categories_data/categories_data_state.dart';

class CategoriesDataCubit extends Cubit<CategoriesDataState> {
  final GetCategoryByIdUseCase getCategoryByIdUseCase;

  CategoriesDataCubit({required this.getCategoryByIdUseCase}) : super(CategoriesDataInitial());

  Future<void> getCategoryData(int id) async {
    emit(CategoriesDataLoading());
    final result = await getCategoryByIdUseCase(id);
    result.fold(
      (failure) => emit(CategoriesDataError(message: failure.toString())),
      (category) => emit(CategoriesDataLoaded(currentCategory: category)),
    );
  }
}
