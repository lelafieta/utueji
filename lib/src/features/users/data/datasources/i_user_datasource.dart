import '../../../auth/domain/entities/user_entity.dart';

abstract class IUserDataSource {
  Stream<UserEntity> getUserById(String id);
}
