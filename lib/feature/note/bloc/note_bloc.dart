import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project_template/feature/note/view/note_view.dart';
import 'package:flutter_project_template/model/note.dart';
import 'package:flutter_project_template/repository/local_repository.dart';
import 'package:flutter_project_template/repository/mock_repository.dart';
import 'package:uuid/uuid.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final MockRepository _mockRepository;

  NoteBloc({
    required MockRepository mockRepository,
  })  : _mockRepository = mockRepository,
        super(const NoteState()) {
    on<NoteInitRequested>(_onInitRequested);
    on<NoteSelected>(_onSelected);
    on<NoteAdded>(_onAdded);
    on<NoteDeleted>(_onDeleted);
    on<NoteUpdated>(_onUpdated);
  }

  void _onInitRequested(
    NoteInitRequested event,
    Emitter<NoteState> emit,
  ) async {
    emit(state.copyWith(noteStatus: NoteStatus.loading));
    try {
      final notes = await _mockRepository.getNotes();

      emit(state.copyWith(
        notes: notes,
        noteStatus: NoteStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        noteStatus: NoteStatus.failed,
        error: e.toString(),
      ));
    }
  }

  void _onSelected(
    NoteSelected event,
    Emitter<NoteState> emit,
  ) async {
    emit(state.copyWith(noteStatus: NoteStatus.loading));
    try {
      final note = await _mockRepository.getNote(event.id);
      emit(state.copyWith(
        note: note,
        noteStatus: NoteStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        noteStatus: NoteStatus.failed,
        error: e.toString(),
      ));
    }
  }

  void _onAdded(
    NoteAdded event,
    Emitter<NoteState> emit,
  ) async {
    if (event.title.isEmpty || event.content.isEmpty) return;

    emit(state.copyWith(noteStatus: NoteStatus.loading));
    try {
      final newNote = Note(
          id: const Uuid().v4(), title: event.title, content: event.content);

      final notesString = LocalRepository().getString("notes");

      final notesJson = jsonDecode(notesString!);
      final notes =
          (notesJson as List).map((note) => Note.fromJson(note)).toList();
      notes.add(newNote);
      LocalRepository().setString("notes", jsonEncode(notes));

      emit(state.copyWith(
        notes: notes,
        noteStatus: NoteStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        noteStatus: NoteStatus.failed,
        error: e.toString(),
      ));
    }
  }

  void _onDeleted(
    NoteDeleted event,
    Emitter<NoteState> emit,
  ) async {
    emit(state.copyWith(noteStatus: NoteStatus.loading));
    try {
      final notesString = LocalRepository().getString("notes");

      final notesJson = jsonDecode(notesString!);
      final notes =
          (notesJson as List).map((note) => Note.fromJson(note)).toList();
      notes.removeWhere((note) => note.id == event.id);
      LocalRepository().setString("notes", jsonEncode(notes));

      emit(state.copyWith(
        notes: notes,
        noteStatus: NoteStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        noteStatus: NoteStatus.failed,
        error: e.toString(),
      ));
    }
  }

  void _onUpdated(
    NoteUpdated event,
    Emitter<NoteState> emit,
  ) async {
    emit(state.copyWith(noteEditStatus: NoteEditStatus.loading));
    try {
      final updatedNote = Note(
        id: event.note.id,
        title: event.note.title,
        content: event.note.content,
      );

      final notesString = LocalRepository().getString("notes");

      final notesJson = jsonDecode(notesString!);
      final notes =
          (notesJson as List).map((note) => Note.fromJson(note)).toList();
      notes[notes.indexWhere((note) => note.id == event.note.id)] = updatedNote;
      LocalRepository().setString("notes", jsonEncode(notes));

      emit(state.copyWith(
        notes: notes,
        noteEditStatus: NoteEditStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        noteEditStatus: NoteEditStatus.failed,
        error: e.toString(),
      ));
    }
  }
}
