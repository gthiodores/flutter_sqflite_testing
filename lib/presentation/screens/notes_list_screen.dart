import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sqflite_testing/data/alias/notes_entity.dart';
import 'package:flutter_sqflite_testing/presentation/providers/notes_list/notes_list_provider.dart';
import 'package:flutter_sqflite_testing/presentation/screens/notes_detail_screen.dart';
import 'package:flutter_sqflite_testing/presentation/utils/state.dart'
    as my_state;
import 'package:flutter_sqflite_testing/presentation/widgets/failure_widget.dart';
import 'package:flutter_sqflite_testing/presentation/widgets/loading_widget.dart';
import 'package:flutter_sqflite_testing/presentation/widgets/notes_list_item_view.dart';

class NotesListScreen extends ConsumerWidget {
  const NotesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Begins observing the notes list.
    my_state.State<NotesList> noteState = ref.watch(notesListNotifier);

    // Listen to messages from the notifier and display a snackbar accordingly.
    ref.listen<my_state.State<NotesList>>(notesListNotifier, (previous, next) {
      next.when(
          success: (success) {
            if (success.message == null) return;

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(success.message!)));
          },
          loading: (_) {},
          failure: (failure) {
            if (failure.message == null) return;

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(failure.message!)));
          });
    });

    // Rebuild the widget when the state changes.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: noteState.when(
        success: (success) {
          final notes = success.data;
          return _buildListView(notes, false, onTap: (id) {
            _onListItemTap(context, id);
          }, onDismiss: (id) {
            _onListItemDismiss(id, ref);
          });
        },
        loading: (loading) {
          final notes = loading.data ?? [];
          return _buildListView(notes, true, onTap: (id) {
            _onListItemTap(context, id);
          }, onDismiss: (id) {
            _onListItemDismiss(id, ref);
          });
        },
        failure: (failure) {
          final notes = failure.data ?? [];
          return notes.isEmpty
              ? const FailureWidget()
              : _buildListView(notes, false, onTap: (id) {
                  _onListItemTap(context, id);
                }, onDismiss: (id) {
                  _onListItemDismiss(id, ref);
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

  void _onListItemTap(BuildContext context, int? id) {
    Navigator.pushNamed(
      context,
      NotesDetailScreen.route,
      arguments: id,
    );
  }

  void _onListItemDismiss(int? id, WidgetRef ref) {
    if (id == null) return;

    final notifier = ref.read(notesListNotifier.notifier);
    notifier.removeNote(id);
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
          return NotesListItemView(
            note,
            onDismissed: () {
              onDismiss?.call(note.id);
            },
            onTap: () {
              onTap?.call(note.id);
            },
          );
        }

        // Shows loading if loading additional data or an empty box otherwise.
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
