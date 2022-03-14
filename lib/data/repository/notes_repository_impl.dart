import 'package:flutter_sqflite_testing/data/alias/notes_entity.dart';
import 'package:flutter_sqflite_testing/data/datasource/database/notes_database_interface.dart';
import 'package:flutter_sqflite_testing/domain/model/note.dart';
import 'package:flutter_sqflite_testing/domain/repository/notes_repository_interface.dart';

class NotesRepository extends INotesRepository {
  final INotesDatabase _notesDatabase;

  NotesRepository(this._notesDatabase);

  @override
  Future<void> deleteNote(int id) async {
    await _notesDatabase.deleteNote(id);
  }

  @override
  Future<NotesList> getAllNotes() async {
    return await _notesDatabase.getAllNotes();
  }

  @override
  Future<Note> getNote(int id) async {
    return await _notesDatabase.getSingleNote(id);
  }

  @override
  Future<void> updateNote(Note note) async {
    await _notesDatabase.updateNote(note.toMap());
  }

  @override
  Future<Note> insertNote(Note note) async {
    final newId = await _notesDatabase.insertNote(note.toMap());
    return note.copy(id: newId);
  }
}
