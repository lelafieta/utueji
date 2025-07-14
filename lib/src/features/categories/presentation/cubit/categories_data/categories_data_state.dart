part of 'categories_data_cubit.dart';

sealed class CategoriesDataState extends Equatable {
  const CategoriesDataState();

  @override
  List<Object> get props => [];
}

final class CategoriesDataInitial extends CategoriesDataState {}

final class CategoriesDataLoading extends CategoriesDataState {}

final class CategoriesDataLoaded extends CategoriesDataState {
  import '../../../domain/entities/category_entity.dart';

final class CategoriesDataLoaded extends CategoriesDataState {
  final CategoryEntity currentCategory;

  const CategoriesDataLoaded({required this.currentCategory});

  @override
  List<Object> get props => [currentCategory];
}

final class CategoriesDataError extends CategoriesDataState {
  final String message;

  const CategoriesDataError({required this.message});

  @override
  List<Object> get props => [message];
}
