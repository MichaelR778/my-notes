import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:my_notes/features/note/domain/repositories/note_repository.dart';
import 'package:my_notes/utils/encrypt_util.dart';

class CreateNote {
  final NoteRepository _noteRepository;

  CreateNote({required NoteRepository noteRepository})
      : _noteRepository = noteRepository;

  Future<void> call(String title, Document document) async {
    final content = jsonEncode(document.toDelta().toJson());
    final encrypted = encrypt(content);
    await _noteRepository.createNote(title, encrypted);
  }
}
