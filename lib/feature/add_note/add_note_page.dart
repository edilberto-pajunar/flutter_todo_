import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/feature/add_note/add_note_view.dart';
import 'package:flutter_project_template/feature/note/bloc/note_bloc.dart';

class AddNotePage extends StatelessWidget {
  static String route = "add_note_route";
  const AddNotePage({
    required this.noteBloc,
    super.key,
  });

  final NoteBloc noteBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: noteBloc,
      child: const AddNoteView(),
    );
  }
}
