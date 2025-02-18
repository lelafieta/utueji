import 'package:utueji/src/features/ongs/domain/entities/ong_entity.dart';

import '../../domain/respositories/i_ong_repository.dart';
import '../datasources/i_ong_datasource.dart';

class OngRepository extends IOngRepository {
  final IOngDataSource datasource;
  OngRepository({required this.datasource});
  @override
  Stream<List<OngEntity>> fetchLatestOngs() {
    return datasource.fetchLatestOngs();
  }
}
