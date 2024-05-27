import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peqing/data/models/lecturer.dart';
import 'package:peqing/data/repositories/lecturer_repository.dart';

part 'lecturer_event.dart';
part 'lecturer_state.dart';

class LecturerBloc extends Bloc<LecturerEvent, LecturerState> {
  final LecturerRepository _lecturerRepository;

  LecturerBloc(this._lecturerRepository) : super(LecturerLoading()) {
    on<LoadLecturer>(_loadLecturer);
    on<_RetryLoadLecturer>(_retryLoadLecturer);
    on<DeleteLecturer>(_deleteLecturer);
    add(LoadLecturer());
  }

  Future<void> _loadLecturer(
      LoadLecturer event, Emitter<LecturerState> emit) async {
    emit(LecturerLoading(lecturers: event.lecturers));
    try {
      final lecturers = await _lecturerRepository.getAll();
      emit(LecturerLoaded(lecturers: lecturers));
    } catch (e) {
      emit(LecturerError(message: e.toString()));
      add(_RetryLoadLecturer());
    }
  }

  Future<void> _retryLoadLecturer(
      _RetryLoadLecturer event, Emitter<LecturerState> emit) async {
    emit(LecturerLoading());
    try {
      await Future.delayed(const Duration(seconds: 5));
      final lecturers = await _lecturerRepository.getAll();
      emit(LecturerLoaded(lecturers: lecturers));
    } catch (e) {
      if (!isClosed) add(_RetryLoadLecturer());
    }
  }

  Future<void> _deleteLecturer(
      DeleteLecturer event, Emitter<LecturerState> emit) async {
    emit(LecturerLoading(lecturers: (state as LecturerLoaded).lecturers));
    try {
      await _lecturerRepository.deleteById(event.id);
      add(LoadLecturer(lecturers: (state as LecturerLoaded).lecturers));
    } catch (e) {
      emit(LecturerLoaded(
          lecturers: (state as LecturerLoading).lecturers!,
          message: e.toString()));
    }
  }
}
