import 'package:flutter/material.dart';
import 'package:utueji/src/app/app.dart';
import './src/app/di.dart' as di;

void main() {
  di.init();
  runApp(const UtuejiApp());
}
