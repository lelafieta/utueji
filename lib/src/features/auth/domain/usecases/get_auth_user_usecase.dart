import '../../../../core/entities/no_params.dart';
import '../../../../core/usecases/stream_usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

class GetAuthUserUseCase extends StreamUseCase<UserEntity, NoParams> {
  final IAuthRepository repository;

  GetAuthUserUseCase({required this.repository});
  @override
  Stream<UserEntity> call(NoParams params) {
    return repository.authUser();
  }
}
