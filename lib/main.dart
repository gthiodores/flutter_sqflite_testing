import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sqflite_testing/presentation/screens/notes_detail_screen.dart';
import 'package:flutter_sqflite_testing/presentation/screens/notes_list_screen.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == NotesDetailScreen.route) {
          final args = settings.arguments as int?;
          return MaterialPageRoute(builder: ((context) {
            return NotesDetailScreen(notesId: args);
          }));
        }
        return null;
      },
      home: const NotesListScreen(),
    );
  }
}
