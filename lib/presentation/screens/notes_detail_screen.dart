import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sqflite_testing/presentation/providers/notes_detail/notes_detail_provider.dart';
import 'package:flutter_sqflite_testing/presentation/providers/notes_list/notes_list_provider.dart';

import '../../domain/model/note.dart';

class NotesDetailScreen extends ConsumerStatefulWidget {
  static String route = "/detail";

  final int? notesId;

  const NotesDetailScreen({
    Key? key,
    required this.notesId,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotesDetailState();
}

class _NotesDetailState extends ConsumerState<NotesDetailScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late Note? _note;

  @override
  void initState() {
    super.initState();
    _initializeNote();
  }

  void _initializeNote() async {
    _note = widget.notesId != null
        ? await ref.read(noteDetailProvider(widget.notesId!))
        : Note(title: "", description: "");
    setState(() {
      _titleController.text = _note?.title ?? "";
      _descriptionController.text = _note?.description ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final _notesListNotifier = ref.read(notesListNotifier.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Simpan'),
                onPressed: () async {
                  if (widget.notesId == null) {
                    _notesListNotifier.addNote(
                      Note(
                        title: _titleController.text,
                        description: _descriptionController.text,
                      ),
                    );
                  } else {
                    _notesListNotifier.updateNote(
                      _note!.copy(
                          title: _titleController.text,
                          description: _descriptionController.text),
                    );
                  }
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
