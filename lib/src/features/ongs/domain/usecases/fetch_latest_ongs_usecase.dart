import '../../../../core/entities/no_params.dart';
import '../../../../core/usecases/stream_usecase.dart';
import '../entities/ong_entity.dart';
import '../respositories/i_ong_repository.dart';

class FetchLatestOngsUsecase extends StreamUseCase<List<OngEntity>, NoParams> {
  final IOngRepository repository;

  FetchLatestOngsUsecase({required this.repository});

  @override
  Stream<List<OngEntity>> call(NoParams params) {
    return repository.fetchLatestOngs();
  }
}
