part of 'lecturer_bloc.dart';

@immutable
sealed class LecturerEvent {}

final class LoadLecturer extends LecturerEvent {
  final List<Lecturer>? lecturers;
  final String? message;

  LoadLecturer({this.lecturers, this.message});
}

final class CreateLecturer extends LecturerEvent {
  final Lecturer lecturer;

  CreateLecturer(this.lecturer);
}

final class UpdateLecturer extends LecturerEvent {
  final Lecturer lecturer;

  UpdateLecturer(this.lecturer);
}

final class DeleteLecturer extends LecturerEvent {
  final int id;

  DeleteLecturer(this.id);
}

final class _RetryLoadLecturer extends LecturerEvent {}
