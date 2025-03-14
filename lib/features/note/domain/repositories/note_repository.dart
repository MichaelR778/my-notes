import 'package:my_notes/features/note/domain/entities/note.dart';

abstract class NoteRepository {
  Future<List<Note>> fetchNotes();
  Future<void> createNote(String title, String content);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String noteId);
}
