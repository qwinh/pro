import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/journal_entry.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _tagController = TextEditingController();

  List<String> _tempTags = [];

  void _addTag() {
    if (_tagController.text.isNotEmpty) {
      setState(() {
        _tempTags.add(_tagController.text);
        _tagController.clear();
      });
    }
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      // Simulate saving to DB by adding to mock list
      final newEntry = JournalEntry(
        id: const Uuid().v4(),
        title: _titleController.text,
        content: _contentController.text,
        date: DateTime.now(),
        tags: List.from(_tempTags),
      );

      mockEntries.insert(0, newEntry); // Add to top of list
      context.go('/'); // Navigate back home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Entry')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Input
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),

              // Body Input
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'How was your day?',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Content cannot be empty' : null,
              ),
              const SizedBox(height: 16),

              // Tag Manager (Simple Version)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _tagController,
                      decoration: const InputDecoration(
                        labelText: 'Add a tag (e.g. Work)',
                        isDense: true,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _addTag,
                    icon: const Icon(Icons.add_circle),
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                children: _tempTags
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        onDeleted: () => setState(() => _tempTags.remove(tag)),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton.icon(
                  onPressed: _saveEntry,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Entry'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
