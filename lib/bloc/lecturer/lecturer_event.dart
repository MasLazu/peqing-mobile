part of 'lecturer_bloc.dart';

@immutable
sealed class LecturerEvent {}

final class LoadLecturer extends LecturerEvent {}

final class _RetryLoadLecturer extends LecturerEvent {}
