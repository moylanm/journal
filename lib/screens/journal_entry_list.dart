import 'package:flutter/material.dart';
import 'package:journal/db/database_manager.dart';
import 'package:journal/db/journal_entry_dao.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/screens/journal_entry.dart';
import 'package:journal/widgets/journal_entry_form.dart';
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
    final journalEntries = await _getJournalEntries();

    if (mounted) {
      setState(() {
        journal = Journal(journalEntries);
      });
    }
  }

  Future<List<JournalEntry>> _getJournalEntries() async {
    final dbm = DatabaseManager.getInstance();
    return await JournalEntryDAO.journalEntries(dbm);
  }
  
  @override
  Widget build(BuildContext context) {
    return JournalScaffold(
      title: journal.isEmpty ? 'Welcome' : 'Journal Entries',
      body: journal.isEmpty ? welcome() : LayoutBuilder(builder: _layoutDesignator),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('New Entry'),
        icon: const Icon(Icons.add),
        onPressed:() async {
          final popResult = await Navigator.push<bool>(
            context,
            MaterialPageRoute<bool>(builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('New Journal Entry'),
                ),
                body: const JournalEntryForm()
              );
            })
          );

          if (popResult!) {
            final journalEntries = await _getJournalEntries();

            setState(() {
              journal = Journal(journalEntries);
            });
          }
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
        return ListTile(
          title: Text(journal[index].title),
          subtitle: Text(journal[index].formattedDate),
          onTap:() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JournalEntryScreen(entry: journal[index]))
            );
          },
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
          const SizedBox(width: 80),
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
          return ListTile(
            title: Text(widget.journal[index].title),
            subtitle: Text(widget.journal[index].formattedDate),
            onTap:() {
              setState(() {
                currentIndex = index;
              });
            },
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.journal[currentIndex].title, style: const TextStyle(fontSize: 25)),
              Text('Rating: ${widget.journal[currentIndex].rating}'),
              const SizedBox(height: 10.0),
              Text(widget.journal[currentIndex].body),
            ],
          ),
        ),
      ),
    );
  }
}