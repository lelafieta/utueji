import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/supabase/supabase_consts.dart';
import '../../domain/entities/ong_entity.dart';
import '../models/ong_model.dart';
import 'i_ong_datasource.dart';

class OngDataSource extends IOngDataSource {
  final SupabaseClient supabase;
  OngDataSource({required this.supabase});
  @override
  Stream<List<OngEntity>> fetchLatestOngs() {
    final ongs = supabase
        .from(SupabaseConsts.ongs)
        .select("*, user:profiles(*)")
        .order('created_at')
        .limit(10)
        .asStream()
        .map((data) {
      return data.map((ong) => OngModel.fromMap(ong)).toList();
    });

    return ongs;
  }
}
