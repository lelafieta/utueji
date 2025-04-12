import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utueji/src/core/supabase/supabase_consts.dart';

import '../../../../core/errors/failures.dart';
import '../models/user_model.dart';
import 'i_auth_datasource.dart';

class AuthDataSource implements IAuthDataSource {
  final SupabaseClient supabase;

  AuthDataSource({required this.supabase});
  @override
  Future<bool> isSignIn() async {
    return supabase.auth.currentUser != null;
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
        throw ServerFailure(message: 'Usuário não encontrado.');
      }

      final profileResponse = await supabase
          .from(SupabaseConsts.profiles)
          .select()
          .eq('id', user.id)
          .single();

      return UserModel.fromJson(profileResponse);
    } catch (e) {
      print(e);
      throw ServerFailure(message: 'Erro inesperado ao tentar fazer login.');
    }
  }

  @override
  Future<Unit> signOut() async {
    try {
      await supabase.auth.signOut();
      return unit;
    } catch (e) {
      throw ServerFailure(message: 'Erro ao fazer logout');
    }
  }

  @override
  Future<UserModel?> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Unit> signInWithOtp(String phone) async {
    try {
      await supabase.auth.signInWithOtp(phone: phone);
      return unit;
    } catch (e) {
      print(e);
      throw ServerFailure(message: 'Erro ao fazer Login $e');
    }
  }

  @override
  Future<UserModel> authUser() async {
    try {
      final profileResponse = await supabase
          .from(SupabaseConsts.profiles)
          .select()
          .eq('id', supabase.auth.currentUser!.id)
          .single();

      return UserModel.fromJson(profileResponse);
    } catch (e) {
      print(e);
      throw ServerFailure(message: 'Erro ao buscar usuário autenticado.');
    }
  }
}
