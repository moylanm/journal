class JournalEntryDTO {
  final String title;
  final String body;
  final int rating;
  final DateTime dateTime;

  JournalEntryDTO({
    required this.title,
    required this.body,
    required this.rating,
    required this.dateTime
  });
}