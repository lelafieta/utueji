import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utueji/src/app/app.dart';
import './src/app/di.dart' as di;
import 'src/core/supabase/supabase_consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(
    url: SupabaseConsts.supabaseUrl,
    anonKey: SupabaseConsts.supabaseKey,
  );
  await di.init();

  runApp(const UtuejiApp());
}
