import 'package:flutter_sqflite_testing/data/alias/notes_entity.dart';
import 'package:flutter_sqflite_testing/data/datasource/database/notes_database_interface.dart';
import 'package:flutter_sqflite_testing/domain/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase extends INotesDatabase {
  // Database configuration
  final String _databaseName = 'notes_database';
  final String _tableName = 'notes_table';
  final int _databaseVersion = 1;

  // Note Columns
  final String _noteId = "id";
  final String _noteTitle = "title";
  final String _noteDescription = "description";

  static Database? _instance;

  Future<Database> get database async {
    return _instance ??= await _initializeDb();
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, '$_databaseName.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               $_noteId INTEGER PRIMARY KEY,
               $_noteTitle TEXT, $_noteDescription TEXT
             )''',
        );
      },
      version: _databaseVersion,
    );

    return db;
  }

  @override
  Future<void> deleteNote(int id) async {
    final db = await database;
    db.delete(
      _tableName,
      where: ' $_noteId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<NotesList> getAllNotes() async {
    final db = await database;
    final dbObject = await db.query(_tableName);
    return dbObject.map((map) => Note.fromMap(map)).toList();
  }

  @override
  Future<Note> getSingleNote(int id) async {
    final db = await database;
    final dbObject = await db.query(
      _tableName,
      where: "$_noteId = ?",
      whereArgs: [id],
    );
    return Note.fromMap(dbObject.first);
  }

  @override
  Future<int> insertNote(DbEntity entity) async {
    final db = await database;
    return await db.insert(_tableName, entity);
  }

  @override
  Future<void> updateNote(DbEntity entity) async {
    final db = await database;
    db.update(
      _tableName,
      entity,
      where: "$_noteId = ?",
      whereArgs: [entity[_noteId] as int],
    );
  }
}
