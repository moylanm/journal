import 'package:flutter/material.dart';
import 'package:journal/db/database_manager.dart';
import 'package:journal/db/journal_entry_dao.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/screens/new_entry.dart';
import 'package:journal/widgets/journal_scaffold.dart';
import 'package:journal/widgets/welcome.dart';

class JournalEntryList extends StatefulWidget {
  static const routeName = '/';

  const JournalEntryList({super.key});

  @override
  State<JournalEntryList> createState() => _JournalEntryListState();
}

class _JournalEntryListState extends State<JournalEntryList> {
  
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Journal? journal;

  @override
  void initState() {
    super.initState();
    _initializeJournal();
  }
  
  @override
  Widget build(BuildContext context) {
    return journalScaffold(
      key: scaffoldKey,
      title: journal == null || journal!.isEmpty ? 'Welcome' : 'Journal Entries',
      body: journal == null || journal!.isEmpty ? welcome() : _journalList(context),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('New Entry'),
        icon: const Icon(Icons.add),
        onPressed:() {
          Navigator.of(context).pushNamed(NewJournalEntry.routeName);
        },
      )
    );
  }

  void _initializeJournal() async {
    final dbm = DatabaseManager.getInstance();
    final journalEntries = await JournalEntryDAO.journalEntries(dbm);

    if (mounted) {
      setState(() {
        journal = Journal(journalEntries);
      });
    }
  }

  Widget _journalList(BuildContext context) {
    return const Placeholder();
  }
}