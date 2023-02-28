import 'package:journal/db/journal_entry_dto.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {

  static const DATABASE_FILENAME = 'journal.sqlite3.db';
  static const SQL_CREATE_SCHEMA = 'CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT, rating INTEGER, date TEXT)';
  static const SQL_INSERT = 'INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?)';
  static const SQL_SELECT = 'SELECT * FROM journal_entries';

  late final Database db;

  static DatabaseManager? _instance;

  DatabaseManager._internal() {
    initialize();
    _instance = this;
  }

  factory DatabaseManager() => _instance ?? DatabaseManager._internal();

  Future initialize() async {
    db = await openDatabase(
      DATABASE_FILENAME,
      onCreate: (db, version) {
        _createTables(db, SQL_CREATE_SCHEMA);
      },
    );
  }

  void _createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveJournalEntry({required JournalEntryDTO dto}) {
    db.transaction( (txn) async {
      await txn.rawInsert(
        SQL_INSERT,
        [dto.title, dto.body, dto.rating, dto.dateTime.toString()]
      );
    });
  }

  Future<List<Map>> journalEntries() async {
    return await db.rawQuery(SQL_SELECT);
  }
}