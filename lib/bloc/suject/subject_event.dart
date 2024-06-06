part of 'subject_bloc.dart';

@immutable
sealed class SubjectEvent {}

final class LoadSubject extends SubjectEvent {
  final List<Subject>? subjects;
  final String? message;

  LoadSubject({this.subjects, this.message});
}

final class DeleteSubject extends SubjectEvent {
  final int id;

  DeleteSubject(this.id);
}

final class CreateSubject extends SubjectEvent {
  final Subject subject;
  final int lecturerId;

  CreateSubject(this.subject, this.lecturerId);
}

final class UpdateSubject extends SubjectEvent {
  final Subject subject;

  UpdateSubject(this.subject);
}

final class _RetryLoadSubject extends SubjectEvent {}
