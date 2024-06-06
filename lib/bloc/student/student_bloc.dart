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
    on<CreateStudent>(_createStudent);
    on<UpdateStudent>(_updateStudent);
    add(LoadStudent());
  }

  Future<void> _loadStudent(
      LoadStudent event, Emitter<StudentState> emit) async {
    emit(StudentLoading(students: event.students));
    try {
      final students = await _studentRepository.getAll();
      emit(StudentLoaded(students: students, message: event.message));
    } catch (e, s) {
      debugPrint('Error: $e, Stack Trace: $s');
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
    } catch (e, s) {
      debugPrint('Error: $e, Stack Trace: $s');
      if (!isClosed) add(_RetryLoadStudent());
    }
  }

  Future<void> _createStudent(
      CreateStudent event, Emitter<StudentState> emit) async {
    emit(StudentLoading(
        students: state is StudentLoaded
            ? (state as StudentLoaded).students
            : (state as StudentLoading).students));
    try {
      await _studentRepository.create(event.student);
      add(LoadStudent(
          students: (state as StudentLoading).students,
          message: 'Civilian berhasil ditambahkan!'));
    } catch (e, s) {
      debugPrint('Error: $e, Stack Trace: $s');
      emit(StudentLoaded(
          students: state is StudentLoaded
              ? (state as StudentLoaded).students
              : (state as StudentLoading).students ?? [],
          message: e.toString()));
    }
  }

  Future<void> _updateStudent(
      UpdateStudent event, Emitter<StudentState> emit) async {
    emit(StudentLoading(
        students: state is StudentLoaded
            ? (state as StudentLoaded).students
            : (state as StudentLoading).students));
    try {
      await _studentRepository.update(event.student);
      add(LoadStudent(
          students: (state as StudentLoading).students,
          message: 'Civilian berhasil diperbarui!'));
    } catch (e, s) {
      debugPrint('Error: $e, Stack Trace: $s');
      emit(StudentLoaded(
          students: state is StudentLoaded
              ? (state as StudentLoaded).students
              : (state as StudentLoading).students ?? [],
          message: e.toString()));
    }
  }

  Future<void> _deleteStudent(
      DeleteStudent event, Emitter<StudentState> emit) async {
    emit(StudentLoading(
        students: state is StudentLoaded
            ? (state as StudentLoaded).students
            : (state as StudentLoading).students));
    try {
      await _studentRepository.deleteById(event.id);
      add(LoadStudent(
          students: (state as StudentLoading).students,
          message: 'Civilian berhasil dihapus!'));
    } catch (e, s) {
      debugPrint('Error: $e, Stack Trace: $s');
      emit(StudentLoaded(
          students: state is StudentLoaded
              ? (state as StudentLoaded).students
              : (state as StudentLoading).students ?? [],
          message: e.toString()));
    }
  }
}
