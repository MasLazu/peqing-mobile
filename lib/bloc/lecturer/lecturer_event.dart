part of 'lecturer_bloc.dart';

@immutable
sealed class LecturerEvent {}

final class LoadLecturer extends LecturerEvent {
  final List<Lecturer>? lecturers;

  LoadLecturer({this.lecturers});
}

final class DeleteLecturer extends LecturerEvent {
  final int id;

  DeleteLecturer(this.id);
}

final class _RetryLoadLecturer extends LecturerEvent {}
