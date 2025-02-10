import '../../domain/entities/user_profile_entity.dart';

abstract class IUserDataSource {
  Stream<UserProfileEntity> getUserById(String id);
}
