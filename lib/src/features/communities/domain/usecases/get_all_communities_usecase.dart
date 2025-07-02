import 'package:utueji/src/core/usecases/stream_usecase.dart';

import '../../../../core/entities/no_params.dart';
import '../entities/community_entity.dart';
import '../repositories/i_community_repository.dart';

class GetAllCommunitiesUseCase
    extends StreamUseCase<List<CommunityEntity>, NoParams> {
  final ICommunityRepository _repository;

  GetAllCommunitiesUseCase(this._repository);

  @override
  Stream<List<CommunityEntity>> call(NoParams params) {
    return _repository.getAllCommunities();
  }
}
