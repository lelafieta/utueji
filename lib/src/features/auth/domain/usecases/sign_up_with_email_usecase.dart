import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

class SignUpWithEmailUseCase {
  final IAuthRepository repository;
  SignUpWithEmailUseCase({required this.repository});

  Future<UserEntity?> call(String email, String password) async {
    return await repository.signUpWithEmail(email, password);
  }
}
