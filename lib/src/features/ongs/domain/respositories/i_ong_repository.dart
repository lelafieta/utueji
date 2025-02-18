import '../entities/ong_entity.dart';

abstract class IOngRepository {
  Stream<List<OngEntity>> fetchLatestOngs();
}
