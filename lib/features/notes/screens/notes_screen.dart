// lib/features/notes/screens/notes_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/notes_service.dart';
import '../models/note.dart';
import 'note_editor_screen.dart';

final notesServiceProvider = Provider((ref) => NotesService());
final notesProvider = StreamProvider((ref) async* {
  while (true) {
    yield await ref.read(notesServiceProvider).getNotes();
    await Future.delayed(const Duration(seconds: 1));
  }
});

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.transparent,
      ),
      body: notesAsync.when(
        data: (notes) => notes.isEmpty
            ? _buildEmptyState()
            : _buildNotesList(notes, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNote(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_outlined, size: 64, color: Colors.white54),
          SizedBox(height: 16),
          Text(
            'No notes yet',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesList(List<Note> notes, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Card(
          color: Colors.grey[900],
          child: ListTile(
            title: Text(
              note.title.isEmpty ? 'Untitled' : note.title,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              note.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[400]),
            ),
            onTap: () => _editNote(context, note),
          ),
        );
      },
    );
  }

  void _createNote(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(),
      ),
    );
  }

  void _editNote(BuildContext context, Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(note: note),
      ),
    );
  }
}