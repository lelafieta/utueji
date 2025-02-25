import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utueji/src/features/feeds/data/models/feed_model.dart';

import '../../../../core/supabase/supabase_consts.dart';
import 'i_feed_datasource.dart';

class FeedDataSource extends IFeedDataSource {
  final SupabaseClient supabase;

  FeedDataSource({required this.supabase});
  @override
  Stream<List<FeedModel>> fetchFeeds() {
    final feeds = supabase
        .from(SupabaseConsts.feeds)
        .select("*, user:profiles(*), ong:ongs(*)")
        .order('created_at')
        .asStream()
        .map((data) {
      return data.map((feed) => FeedModel.fromMap(feed)).toList();
    });

    return feeds;
  }
}
