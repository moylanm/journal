import 'package:intl/intl.dart';

class JournalEntry {
  final int id;
  final String title;
  final String body;
  final int rating;
  final DateTime date;

  JournalEntry({
    required this.id,
    required this.title,
    required this.body,
    required this.rating,
    required this.date
  });

  JournalEntry.fromMap(Map record) :
    id = record['id'] as int,
    title = record['title'] as String,
    body = record['body'] as String,
    rating = record['rating'] as int,
    date = DateTime.parse(record['date'] as String);

  get formattedDate => DateFormat('EEEE, MMMM d, y').format(date);
}