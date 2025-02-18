import '../../domain/entities/event_entity.dart';
import '../../domain/repositories/i_event_repository.dart';
import '../datasources/i_event_datasource.dart';

class EventRepository extends IEventRepository {
  final IEventDataSource datasource;

  EventRepository({required this.datasource});
  @override
  Stream<List<EventEntity>> fetchLatestEvents() {
    return datasource.fetchLatestEvents();
  }
}
