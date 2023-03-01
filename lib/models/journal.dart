import 'package:journal/models/journal_entry.dart';

class Journal {
  final List<JournalEntry> entries;

  Journal(this.entries);

  Journal.empty() : entries = [];

  get isEmpty => entries.isEmpty;

  get length => entries.length;

  operator [](int i) => entries[i];
}