import '../../domain/entities/favorite_entity.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<FavoriteEntity> favorites;

  FavoriteLoaded({required this.favorites});
}

class FavoriteFailure extends FavoriteState {
  final String failure;

  FavoriteFailure({required this.failure});
}
