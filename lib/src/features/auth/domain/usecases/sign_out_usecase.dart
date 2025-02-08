import '../repositories/i_auth_repository.dart';

class SignOutUseCase {
  final IAuthRepository repository;
  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return await repository.signOut();
  }
}
