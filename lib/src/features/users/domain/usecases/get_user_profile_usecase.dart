import '../../../../core/usecases/stream_usecase.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../repositories/i_user_repository.dart';

class GetUserProfileUseCase extends StreamUseCase<UserEntity, String> {
  final IUserRepository repository;

  GetUserProfileUseCase({required this.repository});

  @override
  Stream<UserEntity> call(String params) {
    return repository.getUserById(params);
  }
}
