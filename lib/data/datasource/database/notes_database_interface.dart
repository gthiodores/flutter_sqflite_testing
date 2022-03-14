import 'package:flutter_sqflite_testing/data/alias/notes_entity.dart';
import 'package:flutter_sqflite_testing/domain/model/note.dart';

abstract class INotesDatabase {
  Future<Note> getSingleNote(int id);

  Future<NotesList> getAllNotes();

  Future<int> insertNote(final DbEntity entity);

  Future<void> updateNote(final DbEntity entity);

  Future<void> deleteNote(final int id);
}
