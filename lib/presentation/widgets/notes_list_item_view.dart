import 'package:flutter/material.dart';
import 'package:flutter_sqflite_testing/domain/model/note.dart';

class NotesListItemView extends StatelessWidget {
  final Note _note;
  final Function()? onTap;
  final Function()? onDismissed;

  const NotesListItemView(
    this._note, {
    Key? key,
    this.onTap,
    this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(_note.id.toString()),
      onDismissed: (direction) {
        onDismissed?.call();
      },
      background: Container(
        color: Colors.red,
      ),
      child: ListTile(
        title: Text(_note.title),
        subtitle: Text(_note.description),
        onTap: () {
          onTap?.call();
        },
      ),
    );
  }
}
