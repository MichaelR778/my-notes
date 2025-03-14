import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_notes/features/note/domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    required super.id,
    required super.title,
    required super.content,
    required super.lastUpdated,
  });

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      lastUpdated: note.lastUpdated,
    );
  }

  factory NoteModel.fromFirebase(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NoteModel(
      id: doc.id,
      title: data['title'],
      content: data['content'],
      lastUpdated: DateTime.parse(data['lastUpdated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
