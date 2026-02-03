import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models/journal_entry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Use the mock data
  final List<JournalEntry> entries = mockEntries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Moments'),
        centerTitle: true,
      ),
      // FAB to navigate to Person B's "Add Screen"
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add'),
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: entries.length,
        separatorBuilder: (ctx, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final entry = entries[index];
          return Card(
            elevation: 2,
            child: ListTile(
              title: Text(entry.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: entry.tags.map((tag) => Container(
                      margin: const EdgeInsets.only(right: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(tag, style: TextStyle(fontSize: 10, color: Colors.teal.shade800)),
                    )).toList(),
                  )
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat('MMM d').format(entry.date)),
                  if (entry.isLiked) const Icon(Icons.favorite, color: Colors.red, size: 16),
                ],
              ),
              // Navigate to Person B's "Detail Screen"
              onTap: () => context.go('/detail/${entry.id}'),
            ),
          );
        },
      ),
    );
  }
}