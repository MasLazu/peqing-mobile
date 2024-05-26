part of 'student_bloc.dart';

@immutable
sealed class StudentEvent {}

final class LoadStudent extends StudentEvent {}

final class _RetryLoadStudent extends StudentEvent {}
