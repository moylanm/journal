import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal/app.dart';
import 'package:journal/db/database_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);
  DatabaseManager.initialize();
  runApp(App(preferences: await SharedPreferences.getInstance()));
}