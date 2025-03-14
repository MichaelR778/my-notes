import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:my_notes/features/note/domain/entities/note.dart';
import 'package:my_notes/features/note/domain/repositories/note_repository.dart';
import 'package:my_notes/utils/encrypt_util.dart';

class UpdateNote {
  final NoteRepository _noteRepository;

  UpdateNote({required NoteRepository noteRepository})
      : _noteRepository = noteRepository;

  Future<void> call(String noteId, String title, Document document) async {
    final content = jsonEncode(document.toDelta().toJson());
    final encrypted = encrypt(content);

    final newNote = Note(
      id: noteId,
      title: title,
      content: encrypted,
      lastUpdated: DateTime.now(),
    );

    await _noteRepository.updateNote(newNote);
  }
}
