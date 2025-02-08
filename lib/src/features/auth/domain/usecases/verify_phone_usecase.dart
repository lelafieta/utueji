import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

class VerifyPhoneUseCase {
  final IAuthRepository repository;
  VerifyPhoneUseCase({required this.repository});
  Future<UserEntity?> call(String verificationId, String smsCode) async {
    return await repository.verifyPhone(verificationId, smsCode);
  }
}
