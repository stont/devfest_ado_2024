import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class NotesService {
  static const String _storageKey = 'notes';

  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getStringList(_storageKey) ?? [];
    return notesJson
        .map((noteStr) => Note.fromJson(jsonDecode(noteStr)))
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  Future<void> saveNote(Note note) async {
    final prefs = await SharedPreferences.getInstance();
    final notes = await getNotes();

    final existingIndex = notes.indexWhere((n) => n.id == note.id);
    if (existingIndex >= 0) {
      notes[existingIndex] = note;
    } else {
      notes.add(note);
    }

    await prefs.setStringList(
      _storageKey,
      notes.map((note) => jsonEncode(note.toJson())).toList(),
    );
  }

  Future<void> deleteNote(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final notes = await getNotes();
    notes.removeWhere((note) => note.id == id);
    await prefs.setStringList(
      _storageKey,
      notes.map((note) => jsonEncode(note.toJson())).toList(),
    );
  }
}