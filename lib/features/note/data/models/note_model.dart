import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_notes/features/note/domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({
    required super.id,
    required super.title,
    required super.content,
  });

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
    );
  }

  factory NoteModel.fromFirebase(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NoteModel(
        id: doc.id, title: data['title'], content: data['content']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}
