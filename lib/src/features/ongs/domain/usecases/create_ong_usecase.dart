import 'package:dartz/dartz.dart';
import 'package:utueji/src/core/errors/failures.dart';

import '../../../../core/usecases/base_usecase.dart';
import '../entities/ong_entity.dart';
import '../respositories/i_ong_repository.dart';

class CreateOngUseCase extends BaseUseCase<Unit, OngEntity> {
  final IOngRepository repository;

  CreateOngUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(OngEntity params) async {
    return await repository.createOng(params);
  }
}
