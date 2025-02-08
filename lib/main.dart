import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:utueji/src/app/app.dart';
import './src/app/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  runApp(const UtuejiApp());
}
