import '../repositories/i_auth_repository.dart';

class IsSignInUseCase {
  final IAuthRepository repository;
  IsSignInUseCase({required this.repository});

  Future<bool> call() async {
    return await repository.isSignIn();
  }
}
