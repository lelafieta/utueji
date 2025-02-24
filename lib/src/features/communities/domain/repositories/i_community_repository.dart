import '../entities/community_entity.dart';

abstract class ICommunityRepository {
  Stream<List<CommunityEntity>> getAllCommunities();
}
