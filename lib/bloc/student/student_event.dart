part of 'student_bloc.dart';

@immutable
sealed class StudentEvent {}

final class LoadStudent extends StudentEvent {
  final List<Student>? students;
  final String? message;

  LoadStudent({this.students, this.message});
}

final class DeleteStudent extends StudentEvent {
  final int id;

  DeleteStudent(this.id);
}

final class CreateStudent extends StudentEvent {
  final Student student;

  CreateStudent(this.student);
}

final class UpdateStudent extends StudentEvent {
  final Student student;

  UpdateStudent(this.student);
}

final class _RetryLoadStudent extends StudentEvent {}
