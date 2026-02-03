import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import 'package:intl/intl.dart';

class EntryDetailScreen extends StatelessWidget {
  final String entryId;

  const EntryDetailScreen({super.key, required this.entryId});

  @override
  Widget build(BuildContext context) {
    // Find the entry that matches the ID passed from Person A's router
    final entry = mockEntries.firstWhere(
      (e) => e.id == entryId,
      orElse: () => JournalEntry(
        id: '0',
        title: 'Error',
        content: 'Not Found',
        date: DateTime.now(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('yyyy-MM-dd').format(entry.date)),
        actions: [
          IconButton(
            icon: Icon(entry.isLiked ? Icons.favorite : Icons.favorite_border),
            color: entry.isLiked ? Colors.red : null,
            onPressed: () {
              // Later we will implement state management here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.title,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: entry.tags.map((t) => Chip(label: Text(t))).toList(),
            ),
            const Divider(height: 30),
            Text(entry.content, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
