import '../entities/feed_entity.dart';
import '../repositories/i_feed_repository.dart';

class FetchFeedsUseCase {
  final IFeedRepository repository;

  FetchFeedsUseCase({required this.repository});

  Stream<List<FeedEntity>> call() {
    return repository.fetchFeeds();
  }
}
