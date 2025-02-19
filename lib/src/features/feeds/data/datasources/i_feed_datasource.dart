import '../models/feed_model.dart';

abstract class IFeedDataSource {
  Stream<List<FeedModel>> fetchFeeds();
}
