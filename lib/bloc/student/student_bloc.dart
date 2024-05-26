import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peqing/data/models/student.dart';
import 'package:peqing/data/repositories/student_repository.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository _studentRepository;

  StudentBloc(this._studentRepository) : super(StudentLoading()) {
    on<LoadStudent>(_loadStudent);
    on<_RetryLoadStudent>(_retryLoadStudent);
    add(LoadStudent());
  }

  Future<void> _loadStudent(
      LoadStudent event, Emitter<StudentState> emit) async {
    emitLoading(emit);
    try {
      final students = await _studentRepository.getAll();
      emit(StudentLoaded(students: students));
    } catch (e) {
      emit(StudentError(message: e.toString()));
      add(_RetryLoadStudent());
    }
  }

  Future<void> _retryLoadStudent(
      _RetryLoadStudent event, Emitter<StudentState> emit) async {
    emitLoading(emit);
    try {
      await Future.delayed(const Duration(seconds: 5));
      final students = await _studentRepository.getAll();
      emit(StudentLoaded(students: students));
    } catch (e) {
      if (!isClosed) add(_RetryLoadStudent());
    }
  }

  void emitLoading(Emitter<StudentState> emit) {
    emit(state is StudentLoaded
        ? StudentLoading(students: (state as StudentLoaded).students)
        : StudentLoading());
  }
}
