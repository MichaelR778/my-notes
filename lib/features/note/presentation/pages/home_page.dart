import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/features/note/presentation/cubits/note_cubit.dart';
import 'package:my_notes/features/note/presentation/cubits/note_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test home page')),
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
                return ListTile(
                  title: Text(note.title),
                );
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
