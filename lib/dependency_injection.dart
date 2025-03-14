import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:my_notes/features/note/data/repositories/firebase_note_repository.dart';
import 'package:my_notes/features/note/domain/repositories/note_repository.dart';
import 'package:my_notes/features/note/domain/usecases/create_note.dart';
import 'package:my_notes/features/note/domain/usecases/delete_note.dart';
import 'package:my_notes/features/note/domain/usecases/fetch_notes.dart';
import 'package:my_notes/features/note/domain/usecases/update_note.dart';
import 'package:my_notes/features/note/presentation/cubits/note_cubit.dart';

final getIt = GetIt.instance;

void initDependencies() {
  // cubit
  getIt.registerLazySingleton(
    () => NoteCubit(
      fetchNotesUsecase: getIt(),
      createNoteUsecase: getIt(),
      updateNoteUsecase: getIt(),
      deleteNoteUsecase: getIt(),
    )..fetchNotes(),
  );

  // usecases
  getIt.registerLazySingleton(() => FetchNotes(noteRepository: getIt()));
  getIt.registerLazySingleton(() => CreateNote(noteRepository: getIt()));
  getIt.registerLazySingleton(() => UpdateNote(noteRepository: getIt()));
  getIt.registerLazySingleton(() => DeleteNote(noteRepository: getIt()));

  // repositories
  getIt.registerLazySingleton<NoteRepository>(
      () => FirebaseNoteRepository(firestore: getIt()));

  // external packages etc
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
}
