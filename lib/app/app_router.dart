import 'package:flutter/material.dart';
import 'package:flutter_project_template/feature/add_note/add_note_page.dart';
import 'package:flutter_project_template/feature/edit_note/edit_note_page.dart';
import 'package:flutter_project_template/feature/note/view/note_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter config = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: "/",
        name: NotePage.route,
        builder: (context, state) => const NotePage(),
      ),
       GoRoute(
        path: "/add-note",
        name: AddNotePage.route,
        builder: (context, state) => AddNotePage(
            noteBloc: (state.extra as Map)["noteBloc"],
        ),
      ),
       GoRoute(
        path: "/edit-note/:noteId",
        name: EditNotePage.route,
        builder: (context, state) => EditNotePage(
          noteId: (state.pathParameters)["noteId"] as String,
          noteBloc: (state.extra as Map)["noteBloc"],
        ),
      ),
    ],
  );
}
