import 'package:flutter/material.dart';
import 'package:journal/screens/journal_entry.dart';
import 'package:journal/screens/journal_entry_list.dart';
import 'package:journal/screens/new_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  static final routes = {
    JournalEntryList.routeName: (context) => const JournalEntryList(),
    JournalEntry.routeName: (context) => const JournalEntry(),
    NewJournalEntry.routeName: (context) => const NewJournalEntry(),
  };

  final SharedPreferences preferences;

  const App({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal',
      theme: preferences.getString('theme') == 'dark' ? ThemeData.dark() : ThemeData.light(),
      routes: routes,
    );
  }
}