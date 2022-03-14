import 'package:flutter_sqflite_testing/data/alias/notes_entity.dart';

abstract class GetAllNotesUseCase {
  Future<NotesList> execute();
}
