import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:my_notes/features/note/data/models/note_model.dart';
import 'package:my_notes/features/note/domain/entities/note.dart';
import 'package:my_notes/features/note/presentation/cubits/note_cubit.dart';
import 'package:my_notes/features/note/presentation/cubits/note_state.dart';
import 'package:my_notes/features/note/presentation/pages/edit_note_page.dart';
import 'package:my_notes/utils/encrypt_util.dart';

class NotePage extends StatefulWidget {
  final Note note;

  const NotePage({super.key, required this.note});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late final QuillController _controller;
  bool _failed = false;
  late Note note = widget.note;

  @override
  void initState() {
    try {
      final decrypted = decrypt(widget.note.content);
      _controller = QuillController(
        document: Document.fromJson(jsonDecode(decrypted)),
        selection: const TextSelection.collapsed(offset: 0),
        readOnly: true,
      );
    } catch (e) {
      setState(() {
        _failed = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteCubit, NoteState>(
      listener: (context, state) {
        if (state is NoteLoaded) {
          final updatedNote = state.notes.firstWhere(
            (n) => n.id == widget.note.id,
            orElse: () => note as NoteModel,
          );

          if (updatedNote != note) {
            setState(() {
              note = updatedNote;
            });
            try {
              final decrypted = decrypt(updatedNote.content);
              _controller.document = Document.fromJson(jsonDecode(decrypted));
            } catch (e) {
              _failed = true;
            }
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(note.title),
          ),
          actions: [
            if (!_failed)
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNotePage(
                            noteId: note.id,
                            title: note.title,
                            document: _controller.document,
                          ),
                        ),
                      );
                    },
                    child: const Text('Edit note'),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      Navigator.pop(context);
                      context.read<NoteCubit>().deleteNote(note.id);
                    },
                    child: const Text('Delete note'),
                  ),
                ],
              ),
          ],
        ),
        body: _failed
            ? const Center(child: Text('Wrong keyword, can\'t open note'))
            : QuillEditor.basic(
                controller: _controller,
                config: const QuillEditorConfig(
                  padding: EdgeInsets.all(20),
                  showCursor: false,
                ),
              ),
      ),
    );
  }
}
