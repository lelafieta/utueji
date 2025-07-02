import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/community_entity.dart';

abstract class ICommunityRepository {
  Stream<List<CommunityEntity>> getAllCommunities();
  Stream<CommunityEntity> getCommunityById(String id);
  Future<Either<Failure, Unit>> createCommunity(CommunityEntity community);
  Future<Either<Failure, Unit>> updateCommunity(CommunityEntity community);
  Future<Either<Failure, Unit>> deleteCommunity(String id);
}
