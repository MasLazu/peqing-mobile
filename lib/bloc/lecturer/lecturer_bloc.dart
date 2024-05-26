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
    add(LoadLecturer());
  }

  Future<void> _loadLecturer(
      LoadLecturer event, Emitter<LecturerState> emit) async {
    emitLoading(emit);
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
    emitLoading(emit);
    try {
      await Future.delayed(const Duration(seconds: 5));
      final lecturers = await _lecturerRepository.getAll();
      emit(LecturerLoaded(lecturers: lecturers));
    } catch (e) {
      if (!isClosed) add(_RetryLoadLecturer());
    }
  }

  void emitLoading(Emitter<LecturerState> emit) {
    emit(state is LecturerLoaded
        ? LecturerLoading(lecturers: (state as LecturerLoaded).lecturers)
        : LecturerLoading());
  }
}
