import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_project_template/app/app_router.dart';
import 'package:flutter_project_template/feature/note/bloc/note_bloc.dart';
import 'package:flutter_project_template/model/note.dart';
import 'package:go_router/go_router.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({
    required this.noteId,
    super.key,
  });

  final String noteId;

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
        actions: [
          TextButton(
            onPressed: () {
              final note = Note(
                id: widget.noteId,
                title: _formKey.currentState!.value["title"],
                content: _formKey.currentState!.value["content"],
              );
              context.read<NoteBloc>().add(NoteUpdated(note: note));
            },
            child: const Text("Update"),
          ),
        ],
      ),
      body: BlocConsumer<NoteBloc, NoteState>(
        listenWhen: (prev, curr) => prev.noteEditStatus != curr.noteEditStatus,
        listener: (context, state) {
          if (state.noteEditStatus == NoteEditStatus.success) {
            context.pop();
          }
        },
        builder: (context, state) {
          if (state.noteStatus == NoteStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return FormBuilder(
            key: _formKey,
            onChanged: () => _formKey.currentState!.save(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBuilderTextField(
                      name: "title",
                      decoration: const InputDecoration(
                        hintText: "Title",
                      ),
                      initialValue: state.note?.title ?? "",
                    ),
                    const SizedBox(height: 12.0),
                    FormBuilderTextField(
                      name: "content",
                      decoration: const InputDecoration(
                        hintText: "Content",
                      ),
                      initialValue: state.note?.content ?? "",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
