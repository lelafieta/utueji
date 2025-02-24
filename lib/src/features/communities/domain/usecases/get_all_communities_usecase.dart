import '../entities/community_entity.dart';
import '../repositories/i_community_repository.dart';

class GetAllCommunitiesUseCase {
  final ICommunityRepository repository;

  GetAllCommunitiesUseCase({required this.repository});

  Stream<List<CommunityEntity>> call() {
    return repository.getAllCommunities();
  }
}
