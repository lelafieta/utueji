import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../entities/community_entity.dart';
import '../repositories/i_community_repository.dart';

class CreateCommunityUseCase extends BaseUseCase<Unit, CommunityEntity> {
  final ICommunityRepository repository;

  CreateCommunityUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(CommunityEntity params) async {
    return await repository.createCommunity(params);
  }
}
