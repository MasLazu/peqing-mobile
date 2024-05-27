part of 'student_bloc.dart';

@immutable
sealed class StudentEvent {}

final class LoadStudent extends StudentEvent {
  final List<Student>? students;

  LoadStudent({this.students});
}

final class DeleteStudent extends StudentEvent {
  final int id;

  DeleteStudent(this.id);
}

final class _RetryLoadStudent extends StudentEvent {}
