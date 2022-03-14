import 'package:flutter_sqflite_testing/domain/model/note.dart';
import 'package:flutter_sqflite_testing/domain/usecase/interface/update_note_use_case.dart';

import '../../repository/notes_repository_interface.dart';

class UpdateNoteUseCaseImpl extends UpdateNoteUseCase {
  final INotesRepository _repository;

  UpdateNoteUseCaseImpl(this._repository);

  @override
  Future<Note> execute(Note note) async {
    await _repository.updateNote(note);
    return note;
  }
}
