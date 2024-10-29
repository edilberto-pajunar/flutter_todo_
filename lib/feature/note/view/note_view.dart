import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/app/app_router.dart';
import 'package:flutter_project_template/feature/add_note/add_note_page.dart';
import 'package:flutter_project_template/feature/edit_note/edit_note_page.dart';
import 'package:flutter_project_template/feature/note/bloc/note_bloc.dart';
import 'package:go_router/go_router.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AddNotePage.route, extra: {
            "noteBloc": context.read<NoteBloc>(),
          });
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state.noteStatus == NoteStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.notes?.length ?? 0,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final note = state.notes![index];
                    return ListTile(
                      onTap: () => context.pushNamed(
                        EditNotePage.route,
                        pathParameters: {
                          "noteId": note.id,
                        },
                        extra: {
                          "noteBloc": context.read<NoteBloc>(),
                        },
                      ),
                      leading: Text("${index + 1}"),
                      title: Text(note.title),
                      subtitle: Text(note.content),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value: context.read<NoteBloc>(),
                                child: AlertDialog(
                                  title: const Text("Confirm"),
                                  content: const Text(
                                      "Are you sure you want to delete?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                          ..read<NoteBloc>()
                                              .add(NoteDeleted(id: note.id))
                                          ..pop();
                                      },
                                      child: const Text("Delete"),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
