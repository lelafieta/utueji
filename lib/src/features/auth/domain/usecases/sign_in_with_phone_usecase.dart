import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

class SignInWithPhoneUseCase {
  final IAuthRepository repository;
  SignInWithPhoneUseCase({required this.repository});

  Future<UserEntity?> call(
      String phoneNumber, Function(String, int?) codeSent) async {
    return await repository.signInWithPhone(phoneNumber, codeSent);
  }
}
