import '../entities/feed_entity.dart';

abstract class IFeedRepository {
  Stream<List<FeedEntity>> fetchFeeds();
}
