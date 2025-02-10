import '../entities/user_profile_entity.dart';

abstract class IUserRepository {
  Stream<UserProfileEntity> getUserById(String id);
}
