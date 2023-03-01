import 'package:flutter/material.dart';
import 'package:journal/db/database_manager.dart';
import 'package:journal/db/journal_entry_dao.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/screens/journal_entry.dart';
import 'package:journal/screens/new_entry.dart';
import 'package:journal/widgets/journal_scaffold.dart';
import 'package:journal/widgets/welcome.dart';

class JournalEntryListScreen extends StatefulWidget {

  const JournalEntryListScreen({super.key});

  @override
  State<JournalEntryListScreen> createState() => _JournalEntryListState();
}

class _JournalEntryListState extends State<JournalEntryListScreen> {

  Journal journal = Journal.empty();

  @override
  void initState() {
    super.initState();
    _initializeJournal();
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
  
  @override
  Widget build(BuildContext context) {
    return journalScaffold(
      title: journal.isEmpty ? 'Welcome' : 'Journal Entries',
      body: journal.isEmpty ? welcome() : LayoutBuilder(builder: _layoutDesignator),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('New Entry'),
        icon: const Icon(Icons.add),
        onPressed:() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const  NewJournalEntryScreen())
          );
        },
      )
    );
  }

  Widget _layoutDesignator(BuildContext context, BoxConstraints constraints) {
    return constraints.maxWidth < 500 ? BasicView(journal: journal) : MasterDetailView(journal: journal);
  }
}

class BasicView extends StatelessWidget {
  final Journal journal;

  const BasicView({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: journal.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(journal[index].title),
            subtitle: Text(journal[index].formattedDate),
            onTap:() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JournalEntryScreen(entry: journal[index]))
              );
            },
          ),
        );
      }
    );
  }
}

class MasterDetailView extends StatefulWidget {
  final Journal journal;

  const MasterDetailView({super.key, required this.journal});

  @override
  State<MasterDetailView> createState() => _MasterDetailViewState();
}

class _MasterDetailViewState extends State<MasterDetailView> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          _masterList(context),
          _detailView(context)
        ],
      ),
    );
  }

 Widget _masterList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ListView.builder(
        itemCount: widget.journal.length,
        itemBuilder: ((context, index) {
          return Card(
            child: ListTile(
              title: Text(widget.journal[index].title),
              subtitle: Text(widget.journal[index].formattedDate),
              onTap:() {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          );
        })
      ),
    );
  }

  Widget _detailView(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(widget.journal[currentIndex].title, style: const TextStyle(fontSize: 25)),
              const SizedBox(height: 10.0),
              Text(widget.journal[currentIndex].body),
            ],
          ),
        ),
      ),
    );
  }
}