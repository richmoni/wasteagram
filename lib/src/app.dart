import 'package:flutter/material.dart';
import 'package:wasteagram/src/screens/list_screen.dart';

/// The top-level application class.
class App extends StatelessWidget {
  /// The title of the application and list screen [AppBar].
  static const String _title = 'Wasteagram';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: ListScreen(title: _title),
    );
  }
}
