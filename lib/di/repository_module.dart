import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sqflite_testing/data/datasource/database/notes_database.dart';
import 'package:flutter_sqflite_testing/data/datasource/database/notes_database_interface.dart';
import 'package:flutter_sqflite_testing/data/repository/notes_repository_impl.dart';
import 'package:flutter_sqflite_testing/domain/repository/notes_repository_interface.dart';

final notesDatabaseProvider = Provider<INotesDatabase>((_) => NotesDatabase());
final notesRepositoryProvider = Provider<INotesRepository>(
    (ref) => NotesRepository(ref.watch(notesDatabaseProvider)));
