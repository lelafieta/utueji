import 'package:dartz/dartz.dart';

import '../../domain/entities/ong_entity.dart';

abstract class IOngDataSource {
  Stream<List<OngEntity>> fetchLatestOngs();
  Future<Unit> createOng(OngEntity ong);
}
