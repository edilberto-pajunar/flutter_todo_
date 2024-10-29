import 'dart:convert';

import 'package:flutter_project_template/model/note.dart';
import 'package:flutter_project_template/model/request.dart';
import 'package:flutter_project_template/repository/api_repository.dart';
import 'package:flutter_project_template/repository/local_repository.dart';

class MockRepository {
  Future<List<Note>> getNotes() async {
    try {
      final req = RequestModel(
        endpoint: "/api/v1/notes",
        type: RequestType.get,
        data: {},
      );

      final response = await ApiRepository().send(req);
      await LocalRepository().setString("notes", jsonEncode(response));
      print("Notes: ${LocalRepository().getString("notes")}");

      final notes =
          (response as List).map((note) => Note.fromJson(note)).toList();

      return notes;
    } catch (e) {
      rethrow;
    }
  }

  Future<Note> getNote(String id) async {
    try {
      final req = RequestModel(
        endpoint: "/api/v1/notes/$id",
        type: RequestType.get,
        data: {},
      );

      final response = await ApiRepository().send(req);
      final note = Note.fromJson(response);
      return note;
    } catch (e) {
      rethrow;
    }
  }
}
