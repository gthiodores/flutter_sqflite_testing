import 'package:flutter_sqflite_testing/domain/repository/notes_repository_interface.dart';
import 'package:flutter_sqflite_testing/domain/usecase/interface/insert_note_use_case.dart';

import '../../model/note.dart';

class InsertNoteUseCaseImpl extends InsertNoteUseCase {
  final INotesRepository _repository;

  InsertNoteUseCaseImpl(this._repository);

  @override
  Future<Note> execute(Note note) async {
    return await _repository.insertNote(note);
  }
}
