import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sqflite_testing/di/repository_module.dart';
import 'package:flutter_sqflite_testing/domain/usecase/concrete/delete_note_use_case_impl.dart';
import 'package:flutter_sqflite_testing/domain/usecase/concrete/get_all_notes_use_case_impl.dart';
import 'package:flutter_sqflite_testing/domain/usecase/concrete/insert_note_use_case_impl.dart';
import 'package:flutter_sqflite_testing/domain/usecase/concrete/update_note_use_case_impl.dart';
import 'package:flutter_sqflite_testing/domain/usecase/interface/delete_note_use_case.dart';
import 'package:flutter_sqflite_testing/domain/usecase/interface/get_all_notes_use_case.dart';
import 'package:flutter_sqflite_testing/domain/usecase/interface/get_note_use_case.dart';
import 'package:flutter_sqflite_testing/domain/usecase/interface/insert_note_use_case.dart';
import 'package:flutter_sqflite_testing/domain/usecase/interface/update_note_use_case.dart';

import '../domain/usecase/concrete/get_note_use_case_impl.dart';

final getAllNotesUseCaseProvider = Provider.autoDispose<GetAllNotesUseCase>(
    (ref) => GetAllNotesUseCaseImpl(ref.watch(notesRepositoryProvider)));

final getNoteUseCaseProvider = Provider.autoDispose<GetNoteUseCase>(
    (ref) => GetNoteUseCaseImpl(ref.watch(notesRepositoryProvider)));

final insertNoteUseCaseProvider = Provider.autoDispose<InsertNoteUseCase>(
    (ref) => InsertNoteUseCaseImpl(ref.watch(notesRepositoryProvider)));

final updateNoteUseCaseProvider = Provider.autoDispose<UpdateNoteUseCase>(
    (ref) => UpdateNoteUseCaseImpl(ref.watch(notesRepositoryProvider)));

final deleteNoteUseCaseProvider = Provider.autoDispose<DeleteNoteUseCase>(
    (ref) => DeleteNoteUseCaseImpl(ref.watch(notesRepositoryProvider)));
