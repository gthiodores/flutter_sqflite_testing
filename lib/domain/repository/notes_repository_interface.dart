import 'package:flutter_sqflite_testing/data/alias/notes_entity.dart';

import '../model/note.dart';

abstract class INotesRepository {
  Future<Note> getNote(int id);

  Future<void> updateNote(Note note);

  Future<void> deleteNote(int id);

  Future<NotesList> getAllNotes();

  Future<Note> insertNote(Note note);
}
