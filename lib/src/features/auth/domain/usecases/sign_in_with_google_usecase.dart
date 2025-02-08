import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

class SignInWithGoogleUseCase {
  final IAuthRepository repository;
  SignInWithGoogleUseCase({required this.repository});

  Future<UserEntity?> call() async {
    return await repository.signInWithGoogle();
  }
}
