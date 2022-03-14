import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sqflite_testing/data/alias/notes_entity.dart';
import 'package:flutter_sqflite_testing/presentation/providers/notes_list/notes_list_provider.dart';
import 'package:flutter_sqflite_testing/presentation/screens/notes_detail_screen.dart';
import 'package:flutter_sqflite_testing/presentation/utils/state.dart'
    as my_state;
import 'package:flutter_sqflite_testing/presentation/widgets/failure_widget.dart';
import 'package:flutter_sqflite_testing/presentation/widgets/loading_widget.dart';

class NotesListScreen extends ConsumerWidget {
  const NotesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    my_state.State<NotesList> noteState = ref.watch(notesListNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: noteState.when(
        success: (success) {
          final notes = success.data;
          return _buildListView(notes, false, onTap: (id) {
            Navigator.pushNamed(
              context,
              NotesDetailScreen.route,
              arguments: id,
            );
          }, onDismiss: (id) {
            if (id == null) return;

            final notifier = ref.read(notesListNotifier.notifier);
            notifier.removeNote(id);
          });
        },
        loading: (loading) {
          final notes = loading.data ?? [];
          return _buildListView(notes, true, onTap: (id) {
            Navigator.pushNamed(
              context,
              NotesDetailScreen.route,
              arguments: id,
            );
          }, onDismiss: (id) {
            if (id == null) return;

            final notifier = ref.read(notesListNotifier.notifier);
            notifier.removeNote(id);
          });
        },
        failure: (failure) {
          final notes = failure.data ?? [];
          return notes.isEmpty
              ? const FailureWidget()
              : _buildListView(notes, false, onTap: (id) {
                  Navigator.pushNamed(
                    context,
                    NotesDetailScreen.route,
                    arguments: id,
                  );
                }, onDismiss: (id) {
                  if (id == null) return;

                  final notifier = ref.read(notesListNotifier.notifier);
                  notifier.removeNote(id);
                });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(NotesDetailScreen.route, arguments: null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView(
    NotesList notes,
    bool loading, {
    Function(int?)? onTap,
    Function(int?)? onDismiss,
  }) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        if (index < notes.length) {
          final note = notes[index];
          return Dismissible(
            key: Key(note.id.toString()),
            onDismissed: (direction) {
              onDismiss?.call(note.id);
            },
            background: Container(
              color: Colors.red,
            ),
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.description),
              onTap: () {
                onTap?.call(note.id);
              },
            ),
          );
        }

        if (loading) {
          return const LoadingWidget();
        } else {
          return const SizedBox();
        }
      }),
      itemCount: notes.length + 1,
    );
  }
}
