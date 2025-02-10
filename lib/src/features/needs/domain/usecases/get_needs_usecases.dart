import '../entities/need_entity.dart';
import '../repositories/i_need_repository.dart';

class GetNeedsUseCase {
  final INeedRepository repository;

  GetNeedsUseCase(this.repository);

  Stream<List<NeedEntity>> call() {
    return repository.getNeeds();
  }
}
