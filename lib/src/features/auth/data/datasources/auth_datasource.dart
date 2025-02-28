import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/failures.dart';
import '../models/user_model.dart';
import 'i_auth_datasource.dart';

class AuthDataSource implements IAuthDataSource {
  final SupabaseClient supabase;

  AuthDataSource({required this.supabase});
  @override
  Future<bool> isSignIn() async {
    return supabase.auth.currentSession != null;
  }

  @override
  Future<UserModel?> signIn(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        throw ServerFailure(error: 'Usuário não encontrado.');
      }
      return UserModel.fromJson(user.toJson());
    } catch (e) {
      throw ServerFailure(error: 'Erro inesperado ao tentar fazer login.');
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
