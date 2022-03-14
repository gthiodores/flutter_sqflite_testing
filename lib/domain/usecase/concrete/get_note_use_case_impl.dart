import 'package:flutter_sqflite_testing/domain/model/note.dart';
import 'package:flutter_sqflite_testing/domain/repository/notes_repository_interface.dart';
import 'package:flutter_sqflite_testing/domain/usecase/interface/get_note_use_case.dart';

class GetNoteUseCaseImpl extends GetNoteUseCase {
  final INotesRepository _repository;

  GetNoteUseCaseImpl(this._repository);

  @override
  Future<Note> execute(int id) async {
    return await _repository.getNote(id);
  }
}
