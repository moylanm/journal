import 'package:flutter/material.dart';
import 'package:journal/db/database_manager.dart';

class JournalEntryForm extends StatefulWidget {
  const JournalEntryForm({super.key});

  @override
  State<JournalEntryForm> createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final _formKey = GlobalKey<FormState>();

  String? title;
  String? body;
  int? rating;

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
                title = value;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'body'),
            validator: (value) => value == null || value == '' ? 'enter a body' : null,
            onSaved:(value) {
              setState(() {
                body = value;
              });
            },
          ),
          DropdownButtonFormField(

            items: const [
              DropdownMenuItem(value: 1, child: Text('1')),
              DropdownMenuItem(value: 2, child: Text('2')),
              DropdownMenuItem(value: 3, child: Text('3')),
              DropdownMenuItem(value: 4, child: Text('4')),
              DropdownMenuItem(value: 5, child: Text('5')),
            ],
            onChanged: (value) {
              setState(() {
                rating = value;
              });
            },
            validator: (value) => value == null ? 'choose a rating' : null,
            onSaved: (value) {
              setState(() {
                rating = value;
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
                      final databaseManager = DatabaseManager.getInstance();
                      // enter into database
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