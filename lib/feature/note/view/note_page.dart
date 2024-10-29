import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/feature/note/bloc/note_bloc.dart';
import 'package:flutter_project_template/feature/note/view/note_view.dart';
import 'package:flutter_project_template/repository/mock_repository.dart';

class NotePage extends StatelessWidget {
  static String route = "note_route";
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc(
        mockRepository: context.read<MockRepository>(),
      )..add(NoteInitRequested()),
      child: const NoteView(),
    );
  }
}
