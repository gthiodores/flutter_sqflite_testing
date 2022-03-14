import 'package:flutter_sqflite_testing/domain/model/note.dart';

abstract class GetNoteUseCase {
  Future<Note> execute(int id);
}
