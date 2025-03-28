import '../../../auth/domain/entities/user_entity.dart';

abstract class IUserRepository {
  Stream<UserEntity> getUserById(String id);
}
