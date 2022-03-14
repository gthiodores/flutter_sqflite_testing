import 'package:flutter_sqflite_testing/domain/usecase/interface/delete_note_use_case.dart';

import '../../repository/notes_repository_interface.dart';

class DeleteNoteUseCaseImpl extends DeleteNoteUseCase {
  final INotesRepository _repository;

  DeleteNoteUseCaseImpl(this._repository);

  @override
  Future<void> execute(int id) async {
    await _repository.deleteNote(id);
  }
}
