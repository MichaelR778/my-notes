import 'package:my_notes/features/note/domain/entities/note.dart';
import 'package:my_notes/features/note/domain/repositories/note_repository.dart';

class FetchNotes {
  final NoteRepository _noteRepository;

  FetchNotes({required NoteRepository noteRepository})
      : _noteRepository = noteRepository;

  Future<List<Note>> call() => _noteRepository.fetchNotes();
}
