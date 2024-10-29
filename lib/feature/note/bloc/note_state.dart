part of 'note_bloc.dart';

enum NoteStatus { idle, loading, success, failed }

enum NoteEditStatus { idle, loading, success, failed }

class NoteState extends Equatable {
  final NoteStatus? noteStatus;
  final List<Note>? notes;
  final Note? note;
  final NoteEditStatus? noteEditStatus;
  final String? error;

  const NoteState({
    this.noteStatus = NoteStatus.idle,
    this.notes = const [],
    this.note,
    this.noteEditStatus = NoteEditStatus.idle,
    this.error,
  });

  NoteState copyWith({
    NoteStatus? noteStatus,
    List<Note>? notes,
    Note? note,
    NoteEditStatus? noteEditStatus,
    String? error,
  }) {
    return NoteState(
      noteStatus: noteStatus ?? this.noteStatus,
      notes: notes ?? this.notes,
      note: note ?? this.note,
      noteEditStatus: noteEditStatus ?? this.noteEditStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        noteStatus,
        notes,
        note,
        noteEditStatus,
        error,
      ];
}
