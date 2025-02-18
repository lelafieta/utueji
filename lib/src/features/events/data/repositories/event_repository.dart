import 'package:utueji/src/features/events/domain/entities/event_entity.dart';

import '../../domain/repositories/i_event_repository.dart';

class EventRepository extends IEventRepository {
  final IEventRepository repository;

  EventRepository({required this.repository});
  @override
  Stream<List<EventEntity>> fetchLatestEvents() {
    return repository.fetchLatestEvents();
  }
}
