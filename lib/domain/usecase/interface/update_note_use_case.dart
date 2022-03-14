import '../../model/note.dart';

abstract class UpdateNoteUseCase {
  Future<Note> execute(Note note);
}
