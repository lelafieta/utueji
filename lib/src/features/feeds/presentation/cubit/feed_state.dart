import '../../domain/entities/feed_entity.dart';

abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<FeedEntity> feeds;

  FeedLoaded({required this.feeds});
}

class FeedFailure extends FeedState {
  final String failure;

  FeedFailure({required this.failure});
}
