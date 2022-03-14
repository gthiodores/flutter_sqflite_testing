import 'package:flutter_sqflite_testing/data/alias/notes_entity.dart';
import 'package:flutter_sqflite_testing/domain/repository/notes_repository_interface.dart';
import 'package:flutter_sqflite_testing/domain/usecase/interface/get_all_notes_use_case.dart';

class GetAllNotesUseCaseImpl extends GetAllNotesUseCase {
  final INotesRepository _repository;

  GetAllNotesUseCaseImpl(this._repository);

  @override
  Future<NotesList> execute() async {
    return await _repository.getAllNotes();
  }
}
