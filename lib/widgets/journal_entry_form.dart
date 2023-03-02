import 'package:flutter/material.dart';
import 'package:journal/db/database_manager.dart';
import 'package:journal/db/journal_entry_dto.dart';

class JournalEntryForm extends StatefulWidget {
  const JournalEntryForm({super.key});

  @override
  State<JournalEntryForm> createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final _formKey = GlobalKey<FormState>();

  String? _title;
  String? _body;
  int? _rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => _renderForm(context),
        ),
      ),
    );
  }

  Widget _renderForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'title'),
            validator: (value) => value == null || value == '' ? 'enter a title' : null,
            onSaved: (value) {
              setState(() {
                _title = value;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'body'),
            validator: (value) => value == null || value == '' ? 'enter a body' : null,
            onSaved:(value) {
              setState(() {
                _body = value;
              });
            },
          ),
          DropdownButtonFormField(
            items: const [
              DropdownMenuItem(value: 1, child: Text('1')),
              DropdownMenuItem(value: 2, child: Text('2')),
              DropdownMenuItem(value: 3, child: Text('3')),
              DropdownMenuItem(value: 4, child: Text('4')),
            ],
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
            validator: (value) => value == null ? 'choose a rating' : null,
            onSaved: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 4),
                ElevatedButton(
                  onPressed: () async {
                    final form = _formKey.currentState;
                    if (form != null && form.validate()) {
                      form.save();
                      final databaseManager = DatabaseManager.getInstance();
                      databaseManager.saveJournalEntry(dto: 
                        JournalEntryDTO(
                          title: _title!,
                          body: _body!, 
                          rating: _rating!,
                          dateTime: DateTime.now()
                        )
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save')
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}