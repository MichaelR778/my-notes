import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:my_notes/features/note/presentation/cubits/note_cubit.dart';

class EditNotePage extends StatefulWidget {
  final String? noteId;
  final String title;
  final Document? document;

  const EditNotePage({
    super.key,
    this.noteId,
    required this.title,
    this.document,
  });

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late final QuillController _quillController;
  final _titleController = TextEditingController();

  void saveNote() {
    if (widget.noteId == null) {
      context.read<NoteCubit>().createNote(
            _titleController.text,
            _quillController.document,
          );
    } else {
      context.read<NoteCubit>().updateNote(
            widget.noteId!,
            _titleController.text,
            _quillController.document,
          );
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    _quillController = QuillController(
      document: widget.document != null
          ? Document.fromDelta(widget.document!.toDelta()) // Creates a copy
          : Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );
    _titleController.text = widget.title;
    super.initState();
  }

  @override
  void dispose() {
    _quillController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _titleController,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => saveNote(),
            child: const Text('Save'),
          ),
        ],
      ),
      body: Column(
        children: [
          QuillSimpleToolbar(
            controller: _quillController,
            config: const QuillSimpleToolbarConfig(),
          ),
          Expanded(
            child: QuillEditor.basic(
              controller: _quillController,
              config: const QuillEditorConfig(
                padding: EdgeInsets.all(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
