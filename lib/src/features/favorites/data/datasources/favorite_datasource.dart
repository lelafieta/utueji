import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/supabase/supabase_consts.dart';
import '../models/favorite_model.dart';

import 'i_favorite_datasource.dart';

class FavoriteDataSource extends IFavoriteDataSource {
  final SupabaseClient supabase;

  FavoriteDataSource({required this.supabase});
  @override
  Future<Unit> addFavorite(FavoriteModel favorite) async {
    try {
      await supabase.from(SupabaseConsts.favorites).insert(favorite.toMap());
      return unit;
    } catch (e) {
      throw ServerFailure(message: 'Erro inesperado ao tentar fazer login.');
    }
  }

  @override
  Stream<List<FavoriteModel>> getAllFavotires() {
    final uid = supabase.auth.currentUser!.id;
    final response = supabase
        .from(SupabaseConsts.favorites)
        .stream(primaryKey: ['id'])
        .eq('user_id', uid)
        .map((data) {
          return data.map((e) => FavoriteModel.fromJson(e)).toList();
        });

    return response;
  }

  @override
  Stream<List<FavoriteModel>> getFavoriteByType() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isMyFavorite(String id) async {
    try {
      final response = await supabase
          .from(SupabaseConsts.favorites)
          .select()
          .eq("item_id", id);

      if (response.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      throw ServerFailure(message: 'Erro inesperado ao tentar fazer login.');
    }
  }

  @override
  Future<Unit> removeFavorite(FavoriteModel favorite) async {
    try {
      final response = await supabase
          .from(SupabaseConsts.favorites)
          .delete()
          .eq("item_id", favorite.itemId!)
          .eq('user_id', favorite.userId!);
      // .gt('age', 18);

      return unit;
    } catch (e) {
      throw ServerFailure(message: 'Erro inesperado ao tentar fazer login.');
    }
  }
}
