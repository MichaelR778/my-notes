import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime lastUpdated;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [id, title, content, lastUpdated];
}
