import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utueji/src/features/events/data/models/event_model.dart';

import '../../../../core/supabase/supabase_consts.dart';
import 'i_event_datasource.dart';

class EventDataSource extends IEventDataSource {
  final SupabaseClient supabase;

  EventDataSource({required this.supabase});
  @override
  Stream<List<EventModel>> fetchLatestEvents() {
    final events = supabase
        .from(SupabaseConsts.events)
        .select("*, user:profiles(*), ong:ongs(*)")
        .order('created_at')
        .limit(10)
        .asStream()
        .map((data) {
      return data.map((event) => EventModel.fromMap(event)).toList();
    }).asBroadcastStream();
    print("object");
    return events;
  }
}
