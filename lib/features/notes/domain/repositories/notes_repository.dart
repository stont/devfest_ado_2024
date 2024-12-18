// lib/features/notes/domain/repositories/notes_repository.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../auth/domain/auth_repository.dart';
import '../models/note.dart';

part 'notes_repository.g.dart';

@riverpod
class NotesRepository extends _$NotesRepository {
  late final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Note>> build() {
    final userId = ref.read(authRepositoryProvider).value?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Note.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    });
  }

  Future<String> createNote(String title, String content, {String? sessionId}) async {
    final userId = ref.read(authRepositoryProvider).value?.uid;
    if (userId == null) throw Exception('User not authenticated');

    final docRef = await _firestore.collection('notes').add({
      'title': title,
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'userId': userId,
      if (sessionId != null) 'sessionId': sessionId,
    });

    return docRef.id;
  }

  Future<void> updateNote(String noteId, {String? title, String? content}) async {
    await _firestore.collection('notes').doc(noteId).update({
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteNote(String noteId) async {
    await _firestore.collection('notes').doc(noteId).delete();
  }
}