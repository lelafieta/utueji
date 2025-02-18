import '../entities/event_entity.dart';

abstract class IEventRepository {
  Stream<List<EventEntity>> fetchLatestEvents();
}
