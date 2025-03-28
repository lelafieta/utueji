import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/repositories/i_user_repository.dart';
import '../datasources/i_user_datasource.dart';

class UserRespository extends IUserRepository {
  final IUserDataSource datasource;

  UserRespository({required this.datasource});

  @override
  Stream<UserEntity> getUserById(String id) {
    return datasource.getUserById(id);
  }
}
