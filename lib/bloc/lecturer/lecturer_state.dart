part of 'lecturer_bloc.dart';

@immutable
sealed class LecturerState {}

final class LecturerLoading extends LecturerState {
  final List<Lecturer>? lecturers;

  LecturerLoading({this.lecturers});
}

final class LecturerLoaded extends LecturerState {
  final List<Lecturer> lecturers;
  final String? message;

  LecturerLoaded({required this.lecturers, this.message});
}

// final class LecturerSearchLoaded extends LecturerState {
//   final List<Lecturer> Lecturers;

//   LecturerSearchLoaded({required this.Lecturers});
// }

final class LecturerError extends LecturerState {
  final String message;

  LecturerError({required this.message});
}
