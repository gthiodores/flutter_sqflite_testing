import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sqflite_testing/di/repository_module.dart';
import 'package:flutter_sqflite_testing/domain/model/note.dart';
import 'package:flutter_sqflite_testing/domain/repository/notes_repository_interface.dart';

final noteDetailProvider = Provider.family.autoDispose<Future<Note>, int>((ref, id) async {
  final INotesRepository _repository = ref.watch(notesRepositoryProvider);
  return await _repository.getNote(id);
});
