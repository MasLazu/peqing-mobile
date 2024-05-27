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
    on<DeleteStudent>(_deleteStudent);
    add(LoadStudent());
  }

  Future<void> _loadStudent(
      LoadStudent event, Emitter<StudentState> emit) async {
    emit(StudentLoading(students: event.students));
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
    emit(StudentLoading());
    try {
      await Future.delayed(const Duration(seconds: 5));
      final students = await _studentRepository.getAll();
      emit(StudentLoaded(students: students));
    } catch (e) {
      if (!isClosed) add(_RetryLoadStudent());
    }
  }

  Future<void> _deleteStudent(
      DeleteStudent event, Emitter<StudentState> emit) async {
    emit(StudentLoading(students: (state as StudentLoaded).students));
    try {
      await _studentRepository.deleteById(event.id);
      print('halo');
      add(LoadStudent(students: (state as StudentLoaded).students));
    } catch (e) {
      print(e);
      emit(StudentLoaded(
          students: (state as StudentLoading).students!,
          message: e.toString()));
    }
  }
}
