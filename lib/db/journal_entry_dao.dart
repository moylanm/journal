import 'package:journal/db/database_manager.dart';
import 'package:journal/models/journal_entry.dart';

class JournalEntryDAO {
  
  static Future<List<JournalEntry>> journalEntries(DatabaseManager dbm) async {
    final journalRecords = await dbm.journalEntries();
    final journalEntries = journalRecords.map( (record) {
      return JournalEntry.fromMap(record);
    }).toList();
    return journalEntries;
  }
}