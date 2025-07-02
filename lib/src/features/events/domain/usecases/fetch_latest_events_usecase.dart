import '../../../../core/entities/no_params.dart';
import '../../../../core/usecases/stream_usecase.dart';
import '../entities/event_entity.dart';
import '../repositories/i_event_repository.dart';

class FetchLatestEventsUsecase
    extends StreamUseCase<List<EventEntity>, NoParams> {
  final IEventRepository repository;

  FetchLatestEventsUsecase({required this.repository});

  @override
  Stream<List<EventEntity>> call(NoParams params) {
    return repository.fetchLatestEvents();
  }
}
