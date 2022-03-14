import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sqflite_testing/data/alias/notes_entity.dart';
import 'package:flutter_sqflite_testing/domain/model/note.dart';
import 'package:flutter_sqflite_testing/domain/usecase/interface/delete_note_use_case.dart';
import 'package:flutter_sqflite_testing/domain/usecase/interface/get_all_notes_use_case.dart';
import 'package:flutter_sqflite_testing/domain/usecase/interface/insert_note_use_case.dart';
import 'package:flutter_sqflite_testing/domain/usecase/interface/update_note_use_case.dart';

import '../../../di/use_case_module.dart';
import '../../utils/state.dart';

final notesListNotifier =
    StateNotifierProvider.autoDispose<NotesNotifier, State<NotesList>>((ref) {
  return NotesNotifier(
    ref.watch(insertNoteUseCaseProvider),
    ref.watch(updateNoteUseCaseProvider),
    ref.watch(deleteNoteUseCaseProvider),
    ref.watch(getAllNotesUseCaseProvider),
  );
});

class NotesNotifier extends StateNotifier<State<NotesList>> {
  final InsertNoteUseCase _insertNote;
  final UpdateNoteUseCase _updateNote;
  final DeleteNoteUseCase _deleteNote;
  final GetAllNotesUseCase _getAllNotes;

  NotesNotifier(
    this._insertNote,
    this._updateNote,
    this._deleteNote,
    this._getAllNotes,
  ) : super(State.success([])) {
    getNotes();
  }

  void getNotes() async {
    try {
      state = State.loading(data: state.getAvailableData());
      final notes = await _getAllNotes.execute();
      state = State.success(notes);
    } catch (e) {
      state = State.failure(e, data: state.getAvailableData());
    }
  }

  void addNote(Note note) async {
    final NotesList _items = state.getAvailableData() ?? [];
    try {
      await _insertNote.execute(note);
      _items.add(note);
      state = State.success(_items);
    } catch (e) {
      state = State.failure(e, data: _items);
    }
  }

  void updateNote(Note note) async {
    final NotesList _items = state.getAvailableData() ?? [];
    try {
      final _newNote = await _updateNote.execute(note);
      final _index = _items.indexWhere((oldNote) => oldNote.id == _newNote.id);
      _items[_index] = _newNote;
      state = State.success(_items);
    } catch (e) {
      state = State.failure(e, data: _items);
    }
  }

  void removeNote(int id) async {
    final NotesList _items = state.getAvailableData() ?? [];
    try {
      await _deleteNote.execute(id);
      _items.removeWhere((note) => note.id == id);
      state = State.success(_items);
    } catch (e) {
      state = State.failure(e, data: _items);
    }
  }
}
