import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/ong_entity.dart';

abstract class IOngRepository {
  Stream<List<OngEntity>> fetchLatestOngs();
  Future<Either<Failure, Unit>> createOng(OngEntity ong);
}
