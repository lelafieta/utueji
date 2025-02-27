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
    // TODO: implement getAllFavotires
    throw UnimplementedError();
  }

  @override
  Stream<List<FavoriteModel>> getAllFavotires() {
    // TODO: implement getAllFavotires
    throw UnimplementedError();
  }

  @override
  Stream<List<FavoriteModel>> getFavoriteByType() {
    // TODO: implement getFavoriteByType
    throw UnimplementedError();
  }

  @override
  Future<bool> isMyFavorite(String id) async {
    print("VARIAVEL $id");
    try {
      final response = await supabase
          .from(SupabaseConsts.favorites)
          .select()
          .eq("item_id", id);

      print("VER AGORA: $response");
      if (response.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      throw ServerFailure(error: 'Erro inesperado ao tentar fazer login.');
    }
  }

  @override
  Future<Unit> removeFavorite(String id) {
    // TODO: implement removeFavorite
    throw UnimplementedError();
  }
}
