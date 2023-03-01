import 'package:flutter/material.dart';
import 'package:journal/widgets/journal_entry_form.dart';

class NewJournalEntry extends StatelessWidget {
  static const routeName = 'new_entry';

  const NewJournalEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Journal Entry'),
      ),
      body: const JournalEntryForm()
    );
  }
}