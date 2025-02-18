import '../entities/event_entity.dart';
import '../repositories/i_event_repository.dart';

class FetchLatestEventsUsecase {
  final IEventRepository repository;

  FetchLatestEventsUsecase({required this.repository});

  Stream<List<EventEntity>> call() {
    return repository.fetchLatestEvents();
  }
}
