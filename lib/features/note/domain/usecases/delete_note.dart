import 'package:my_notes/features/note/domain/repositories/note_repository.dart';

class DeleteNote {
  final NoteRepository _noteRepository;

  DeleteNote({required NoteRepository noteRepository})
      : _noteRepository = noteRepository;

  Future<void> call(String noteId) => _noteRepository.deleteNote(noteId);
}
