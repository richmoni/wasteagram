import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/src/app.dart';

Future<void> main() async {
  // Initialize Firebase before running app.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}
