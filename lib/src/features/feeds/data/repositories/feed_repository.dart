import 'package:utueji/src/features/feeds/domain/entities/feed_entity.dart';

import '../../domain/repositories/i_feed_repository.dart';
import '../datasources/i_feed_datasource.dart';

class FeedRepository extends IFeedRepository {
  final IFeedDataSource datasource;

  FeedRepository({required this.datasource});

  @override
  Stream<List<FeedEntity>> fetchFeeds() {
    return datasource.fetchFeeds();
  }
}
