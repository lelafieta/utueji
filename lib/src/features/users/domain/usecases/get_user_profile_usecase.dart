import '../entities/user_entity.dart';
import '../repositories/i_user_repository.dart';

class GetUserProfileUseCase {
  final IUserRepository repository;

  GetUserProfileUseCase({required this.repository});

  Stream<UserEntity> call(String id) {
    return repository.getUserById(id);
  }
}
