import 'package:flutter/services.dart';
import 'package:journal/db/journal_entry_dto.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {

  static const databaseFilename = 'journal.sqlite3.db';
  static const sqlInsert = 'INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?)';
  static const sqlSelect = 'SELECT * FROM journal_entries';

  static DatabaseManager? _instance;

  late final Database _db;

  DatabaseManager._({required Database database}) : _db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance!;
  }

  static Future<void> initialize() async {
    final db = await openDatabase(
      databaseFilename,
      version: 1,
      onCreate: (db, version) => _createTables(db),
    );
    _instance = DatabaseManager._(database: db);
  }

  static Future<void> _createTables(Database db) async {
    final schema = await rootBundle.loadString('assets/schema_0.sql');
    await db.execute(schema);
  }

  void saveJournalEntry({required JournalEntryDTO dto}) {
    _db.transaction( (txn) async {
      await txn.rawInsert(
        sqlInsert,
        [dto.title, dto.body, dto.rating, dto.dateTime.toString()]
      );
    });
  }

  Future<List<Map>> journalEntries() async {
    return await _db.rawQuery(sqlSelect);
  }
}