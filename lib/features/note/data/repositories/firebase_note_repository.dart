import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_notes/features/note/data/models/note_model.dart';
import 'package:my_notes/features/note/domain/entities/note.dart';
import 'package:my_notes/features/note/domain/repositories/note_repository.dart';

class FirebaseNoteRepository implements NoteRepository {
  final FirebaseFirestore _firestore;

  FirebaseNoteRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<List<Note>> fetchNotes() async {
    final snapshot = await _firestore.collection('notes').get();

    final docs = snapshot.docs;
    return docs.map((doc) => NoteModel.fromFirebase(doc)).toList();
  }

  @override
  Future<void> createNote(String title, String content) async {
    final noteModel = NoteModel(
      id: 'id',
      title: title,
      content: content,
    );
    await _firestore.collection('notes').add(noteModel.toJson());
  }

  @override
  Future<void> updateNote(Note note) async {
    final noteModel = NoteModel.fromEntity(note);
    await _firestore
        .collection('notes')
        .doc(noteModel.id)
        .set(noteModel.toJson());
  }
}
