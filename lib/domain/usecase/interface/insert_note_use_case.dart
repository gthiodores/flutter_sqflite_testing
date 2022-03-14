import '../../model/note.dart';

abstract class InsertNoteUseCase {
  Future<Note> execute(Note note);
}
