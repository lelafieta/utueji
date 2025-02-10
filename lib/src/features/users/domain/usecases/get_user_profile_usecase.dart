import '../entities/user_profile_entity.dart';
import '../repositories/i_user_repository.dart';

class GetUserProfileUseCase {
  final IUserRepository repository;

  GetUserProfileUseCase({required this.repository});

  Stream<UserProfileEntity> call(String id) {
    return repository.getUserById(id);
  }
}
