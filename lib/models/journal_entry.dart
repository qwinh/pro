// lib/models/journal_entry.dart
class JournalEntry {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final List<String> tags;
  bool isLiked;

  JournalEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.tags = const [],
    this.isLiked = false,
  });
}

// MOCK DATA
List<JournalEntry> mockEntries = [
  JournalEntry(
    id: '1',
    title: 'First Flutter Project',
    content: 'We started the group project today. Divided the tasks between A and B.',
    date: DateTime.now().subtract(const Duration(days: 1)),
    tags: ['School', 'Flutter'],
    isLiked: true,
  ),
  JournalEntry(
    id: '2',
    title: 'Coffee at Highlands',
    content: 'Tried the new Freeze. It was too sweet but the view was nice.',
    date: DateTime.now().subtract(const Duration(hours: 5)),
    tags: ['Food', 'Relax'],
  ),
];