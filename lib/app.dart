import 'package:flutter/material.dart';
import 'package:journal/screens/journal_entry_list.dart';

import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  final SharedPreferences preferences;

  const App({super.key, required this.preferences});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  static const themeKey = 'isDarkMode';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _currentThemeMode(),
      home: const JournalEntryListScreen(),
    );
  }

  void swapTheme() {
    bool? darkMode = widget.preferences.getBool(themeKey);

    if (darkMode!) {
      darkMode = false;
    } else {
      darkMode = true;
    }

    setState(() {
      widget.preferences.setBool(themeKey, darkMode!);
    });
  }

  ThemeMode _currentThemeMode() {
    bool? currentTheme = widget.preferences.getBool(themeKey);

    if (currentTheme == null) {
      widget.preferences.setBool(themeKey, false);
      return ThemeMode.light;
    }
    
    return currentTheme ? ThemeMode.dark : ThemeMode.light;
  }
}