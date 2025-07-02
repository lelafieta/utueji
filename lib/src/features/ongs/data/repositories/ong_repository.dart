import 'package:dartz/dartz.dart';
import 'package:utueji/src/core/errors/failures.dart';
import 'package:utueji/src/core/network/network_info.dart';
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

  @override
  Future<Either<Failure, Unit>> createOng(OngEntity ong) async {
    try {
      await datasource.createOng(ong);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
