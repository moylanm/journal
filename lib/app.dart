import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  final SharedPreferences preferences;

  const App({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}