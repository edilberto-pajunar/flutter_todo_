part of 'note_bloc.dart';

class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class NoteInitRequested extends NoteEvent {}

class NoteSelected extends NoteEvent {
  final String id;

  const NoteSelected({
    required this.id,
  });
}

class NoteAdded extends NoteEvent {
  final String title;
  final String content;

  const NoteAdded({
    required this.title,
    required this.content,
  });
}

class NoteUpdated extends NoteEvent {
  final Note note;

  const NoteUpdated({
    required this.note,
  });
}

class NoteDeleted extends NoteEvent {
  final String id;

  const NoteDeleted({
    required this.id,
  });
}
