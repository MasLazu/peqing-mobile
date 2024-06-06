part of 'subject_bloc.dart';

@immutable
sealed class SubjectState {}

final class SubjectLoading extends SubjectState {
  final List<Subject>? subjects;

  SubjectLoading({this.subjects});
}

final class SubjectLoaded extends SubjectState {
  final List<Subject> subjects;
  final String? message;

  SubjectLoaded({required this.subjects, this.message});
}

final class SubjectError extends SubjectState {
  final String message;

  SubjectError({required this.message});
}
