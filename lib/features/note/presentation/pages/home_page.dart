import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/features/note/presentation/cubits/note_cubit.dart';
import 'package:my_notes/features/note/presentation/cubits/note_state.dart';
import 'package:my_notes/features/note/presentation/pages/edit_note_page.dart';
import 'package:my_notes/features/note/presentation/pages/keyword_page.dart';
import 'package:my_notes/features/note/presentation/widgets/note_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void createNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Create a Note'),
          contentPadding: const EdgeInsets.all(16),
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
              onSubmitted: (title) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditNotePage(title: title),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KeywordPage(),
                    ),
                  );
                },
                child: const Text('Change keyword'),
              ),
            ],
          ),
        ],
      ),
      body: BlocConsumer<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NoteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          // loading
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // loaded
          else if (state is NoteLoaded) {
            final notes = state.notes;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteCard(note: note);
              },
            );
          }

          // NoteError etc
          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNote(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
