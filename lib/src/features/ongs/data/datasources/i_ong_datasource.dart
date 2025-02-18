import '../../domain/entities/ong_entity.dart';

abstract class IOngDataSource {
  Stream<List<OngEntity>> fetchLatestOngs();
}
