import '../entities/ong_entity.dart';
import '../respositories/i_ong_repository.dart';

class FetchLatestOngsUsecase {
  final IOngRepository repository;

  FetchLatestOngsUsecase({required this.repository});

  Stream<List<OngEntity>> call() {
    return repository.fetchLatestOngs();
  }
}
