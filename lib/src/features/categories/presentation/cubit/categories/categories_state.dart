part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

import '../../../domain/entities/category_entity.dart';

class CategoriesSuccess extends CategoriesState {
  final List<CategoryEntity> categories;

  const CategoriesSuccess({required this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError({required this.message});

  @override
  List<Object> get props => [message];
}
