import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:my_notes/features/note/domain/usecases/create_note.dart';
import 'package:my_notes/features/note/domain/usecases/delete_note.dart';
import 'package:my_notes/features/note/domain/usecases/fetch_notes.dart';
import 'package:my_notes/features/note/domain/usecases/update_note.dart';
import 'package:my_notes/features/note/presentation/cubits/note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final FetchNotes _fetchNotes;
  final CreateNote _createNote;
  final UpdateNote _updateNote;
  final DeleteNote _deleteNote;

  NoteCubit(
      {required FetchNotes fetchNotesUsecase,
      required CreateNote createNoteUsecase,
      required UpdateNote updateNoteUsecase,
      required DeleteNote deleteNoteUsecase})
      : _fetchNotes = fetchNotesUsecase,
        _createNote = createNoteUsecase,
        _updateNote = updateNoteUsecase,
        _deleteNote = deleteNoteUsecase,
        super(NoteLoading());

  Future<void> fetchNotes() async {
    try {
      emit(NoteLoading());
      final notes = await _fetchNotes();
      emit(NoteLoaded(notes: notes));
    } catch (e) {
      emit(NoteError(message: 'Failed to fetch notes'));
    }
  }

  Future<void> createNote(String title, Document document) async {
    try {
      await _createNote(title, document);
    } catch (e) {
      emit(NoteError(message: 'Failed to create note'));
    } finally {
      fetchNotes();
    }
  }

  Future<void> updateNote(
    String noteId,
    String title,
    Document document,
  ) async {
    try {
      await _updateNote(noteId, title, document);
    } catch (e) {
      emit(NoteError(message: 'Failed to update note'));
    } finally {
      fetchNotes();
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _deleteNote(noteId);
    } catch (e) {
      emit(NoteError(message: 'Failed to delete note'));
    } finally {
      fetchNotes();
    }
  }
}
