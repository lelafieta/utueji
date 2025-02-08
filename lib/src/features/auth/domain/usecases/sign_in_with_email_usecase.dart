import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

class SignInWithEmailUseCase {
  final IAuthRepository repository;
  SignInWithEmailUseCase({required this.repository});

  Future<UserEntity?> call(String email, String password) async {
    return await repository.signInWithEmail(email, password);
  }
}
