part of 'student_bloc.dart';

@immutable
sealed class StudentState {}

final class StudentLoading extends StudentState {
  final List<Student>? students;

  StudentLoading({this.students});
}

final class StudentLoaded extends StudentState {
  final List<Student> students;

  StudentLoaded({required this.students});
}

// final class StudentSearchLoaded extends StudentState {
//   final List<Student> students;

//   StudentSearchLoaded({required this.students});
// }

final class StudentError extends StudentState {
  final String message;

  StudentError({required this.message});
}
