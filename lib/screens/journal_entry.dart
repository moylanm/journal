import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/widgets/journal_scaffold.dart';

class JournalEntryScreen extends StatelessWidget {

  final JournalEntry entry;

  const JournalEntryScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return JournalScaffold(
      title: entry.formattedDate,
      body: _journalBody()
    );
  }

  Widget _journalBody() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry.title, style: const TextStyle(fontSize: 25)),
          Text('Rating: ${entry.rating}'),
          const SizedBox(height: 10.0),
          Text(entry.body),
        ],
      ),
    );
  }
}