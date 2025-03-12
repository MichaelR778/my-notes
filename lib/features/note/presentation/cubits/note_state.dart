import 'package:my_notes/features/note/domain/entities/note.dart';

abstract class NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<Note> notes;

  NoteLoaded({required this.notes});
}

class NoteError extends NoteState {
  final String message;

  NoteError({required this.message});
}
