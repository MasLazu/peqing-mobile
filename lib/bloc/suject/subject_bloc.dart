import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peqing/data/models/subject.dart';
import 'package:peqing/data/repositories/subject_repository.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectRepository _subjectRepository;
  SubjectBloc(this._subjectRepository) : super(SubjectLoading()) {
    on<LoadSubject>(_loadSubject);
    on<_RetryLoadSubject>(_retryLoadSubject);
    on<DeleteSubject>(_deleteSubject);
    on<CreateSubject>(_createSubject);
    on<UpdateSubject>(_updateSubject);
    add(LoadSubject());
  }

  Future<void> _loadSubject(
      LoadSubject event, Emitter<SubjectState> emit) async {
    emit(SubjectLoading(subjects: event.subjects));
    try {
      final subjects = await _subjectRepository.getAll();
      emit(SubjectLoaded(subjects: subjects, message: event.message));
    } catch (e, s) {
      debugPrint('Error: $e, Stack Trace: $s');
      emit(SubjectError(message: e.toString()));
      add(_RetryLoadSubject());
    }
  }

  Future<void> _retryLoadSubject(
      _RetryLoadSubject event, Emitter<SubjectState> emit) async {
    emit(SubjectLoading());
    try {
      await Future.delayed(const Duration(seconds: 5));
      final subjects = await _subjectRepository.getAll();
      emit(SubjectLoaded(subjects: subjects));
    } catch (e, s) {
      debugPrint('Error: $e, Stack Trace: $s');
      if (!isClosed) add(_RetryLoadSubject());
    }
  }

  Future<void> _createSubject(
      CreateSubject event, Emitter<SubjectState> emit) async {
    emit(SubjectLoading(subjects: (state as SubjectLoaded).subjects));
    try {
      await _subjectRepository.create(event.lecturerId, event.subject.name);
      add(LoadSubject(
          subjects: (state as SubjectLoaded).subjects,
          message: 'Mata kuliah berhasil ditambahkan!'));
    } catch (e, s) {
      debugPrint('Error: $e, Stack Trace: $s');
      emit(SubjectLoaded(
          subjects: state is SubjectLoaded
              ? (state as SubjectLoaded).subjects
              : (state as SubjectLoading).subjects ?? [],
          message: e.toString()));
    }
  }

  Future<void> _updateSubject(
      UpdateSubject event, Emitter<SubjectState> emit) async {
    emit(SubjectLoading(subjects: (state as SubjectLoaded).subjects));
    try {
      await _subjectRepository.update(event.subject);
      add(LoadSubject(
          subjects: (state as SubjectLoaded).subjects,
          message: 'Mata kuliah berhasil diperbarui!'));
    } catch (e, s) {
      debugPrint('Error: $e, Stack Trace: $s');
      emit(SubjectLoaded(
          subjects: state is SubjectLoaded
              ? (state as SubjectLoaded).subjects
              : (state as SubjectLoading).subjects ?? [],
          message: e.toString()));
    }
  }

  Future<void> _deleteSubject(
      DeleteSubject event, Emitter<SubjectState> emit) async {
    emit(SubjectLoading(subjects: (state as SubjectLoaded).subjects));
    try {
      await _subjectRepository.deleteById(event.id);
      add(LoadSubject(
          subjects: (state as SubjectLoaded).subjects,
          message: 'Mata kuliah berhasil dihapus!'));
    } catch (e, s) {
      debugPrint('Error: $e, Stack Trace: $s');
      emit(SubjectLoaded(
          subjects: state is SubjectLoaded
              ? (state as SubjectLoaded).subjects
              : (state as SubjectLoading).subjects ?? [],
          message: e.toString()));
    }
  }
}
