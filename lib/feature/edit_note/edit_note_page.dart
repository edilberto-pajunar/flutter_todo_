import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/feature/edit_note/edit_note_view.dart';
import 'package:flutter_project_template/feature/note/bloc/note_bloc.dart';

class EditNotePage extends StatelessWidget {
  static String route = "edit_note_route";
  const EditNotePage({
    required this.noteBloc,
    required this.noteId,
    super.key,
  });

  final NoteBloc noteBloc;
  final String noteId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: noteBloc..add(NoteSelected(id: noteId)),
      child: EditNoteView(
        noteId: noteId,
      ),
    );
  }
}
