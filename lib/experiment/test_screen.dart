import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:my_notes/experiment/mock_db.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final _controller = QuillController.basic();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Editor Test')),
      body: Column(
        children: [
          QuillSimpleToolbar(
            controller: _controller,
            config: const QuillSimpleToolbarConfig(),
          ),
          Expanded(
            child: QuillEditor.basic(
              controller: _controller,
              config: const QuillEditorConfig(),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setData(jsonEncode(_controller.document.toDelta().toJson()));
            },
            child: const Text('Save'),
          ),
          FloatingActionButton(
            onPressed: () {
              _controller.document = Document.fromJson(jsonDecode(data));
            },
            child: const Text('Load'),
          ),
        ],
      ),
    );
  }
}
