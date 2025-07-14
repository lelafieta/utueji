import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:utueji/src/app/app.dart';
import 'package:utueji/src/app/app_entity.dart';
import 'package:utueji/src/features/posts/presentation/pages/posts_page.dart';
import 'package:utueji/src/service_locator.dart';
import 'src/core/cache/secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/core/firebase/firebase_services.dart';
import 'src/core/firebase/local_notification_services.dart';
import 'src/app/di.dart' as di;
import 'package:utueji/src/features/auth/injection_container.dart';
import 'package:utueji/src/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseServices().requestNotificationPermisions();
  await LocalNotificationServices.init();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print(e);
  }
  await di.init();
  setupServiceLocator(); // New line
  await initAuthDependencies();

  SecureCacheHelper.init();
  AppEntity.uid = await SecureCacheHelper().getData(key: "uid");
  await initializeDateFormatting('pt_BR', null);

  runApp(MaterialApp(
    home: BlocProvider<AuthBloc>(
      create: (context) => sl<AuthBloc>(),
      child: const LoginPage(),
    ),
  )); // Changed for demonstration
}
