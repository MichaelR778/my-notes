import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/app.dart';
import 'package:my_notes/dependency_injection.dart';
import 'package:my_notes/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initDependencies();

  runApp(const App());
}
