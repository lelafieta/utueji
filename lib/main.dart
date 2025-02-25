import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utueji/src/app/app.dart';
import './src/app/di.dart' as di;
import 'src/core/supabase/supabase_consts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  await di.init();
  await initializeDateFormatting('pt_BR', null);

  runApp(const UtuejiApp());
}
