import '../models/event_model.dart';

abstract class IEventDataSource {
  Stream<List<EventModel>> fetchLatestEvents();
}
