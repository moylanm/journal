import 'package:flutter/material.dart';
import 'package:journal/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(preferences: await SharedPreferences.getInstance()));
}