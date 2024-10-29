import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_project_template/app/app_router.dart';
import 'package:flutter_project_template/feature/note/bloc/note_bloc.dart';
import 'package:go_router/go_router.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({super.key});

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              context.read<NoteBloc>().add(NoteAdded(
                    title: _formKey.currentState!.value["title"],
                    content: _formKey.currentState!.value["content"],
                  ));
            },
            child: const Text("Save"),
          ),
        ],
      ),
      body: BlocListener<NoteBloc, NoteState>(
        listenWhen: (prev, curr) => prev.noteStatus != curr.noteStatus,
        listener: (context, state) {
          if (state.noteStatus == NoteStatus.success) {
            context.pop();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FormBuilder(
              key: _formKey,
              onChanged: () => _formKey.currentState!.save(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormBuilderTextField(
                    name: "title",
                    decoration: const InputDecoration(
                      hintText: "Title",
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  FormBuilderTextField(
                    name: "content",
                    decoration: const InputDecoration(
                      hintText: "Content",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
