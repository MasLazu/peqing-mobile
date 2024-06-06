import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/material.dart';
import 'package:peqing/data/models/lecturer.dart';
import 'package:peqing/data/models/role.dart';
import 'package:peqing/data/models/student.dart';
import 'package:peqing/data/models/user.dart';
import 'package:peqing/data/repositories/auth_repository.dart';
import 'package:peqing/data/repositories/lecturer_repository.dart';
import 'package:peqing/data/repositories/student_repository.dart';
import 'package:peqing/route/route_names.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  late AuthRepository _authRepository;
  late StudentRepository _studentRepository;
  late LecturerRepository _lecturerRepository;

  AuthBloc() : super(const AuthNotauthenticated()) {
    on<LoginAuth>(_login);
    on<LogoutAuth>(_logout);
  }

  void setAuthRepository({
    required AuthRepository authRepository,
    required StudentRepository studentRepository,
    required LecturerRepository lecturerRepository,
  }) {
    _authRepository = authRepository;
    _studentRepository = studentRepository;
    _lecturerRepository = lecturerRepository;
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    switch (json['role']) {
      case 'admin':
        return AuthAdmin(
            data: User.fromMap(json['data']), token: json['token']);
      case 'lecturer':
        return AuthLecturer(
            data: Lecturer.fromMap(json['data']), token: json['token']);
      case 'student':
        return AuthStudent(
            data: Student.fromMap(json['data']), token: json['token']);
      default:
        return const AuthNotauthenticated();
    }
  }

  @override
  Map<String, dynamic> toJson(AuthState state) {
    Map<String, dynamic> json = {};

    if (state is AuthAuthenticated) {
      json = state.toMap();
      if (state is AuthAdmin) {
        json['role'] = 'admin';
      } else if (state is AuthLecturer) {
        json['role'] = 'lecturer';
      } else if (state is AuthStudent) {
        json['role'] = 'student';
      }
    }

    return json;
  }

  Future<void> _login(LoginAuth event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final res = await _authRepository.login(event.id, event.password);
      final token = res['token']!;
      final role = res['role']!;
      switch (role) {
        case 'dosen':
          emit(AuthLecturer(
              data: await _lecturerRepository.me(token: token), token: token));
          break;
        case 'mahasiswa':
          emit(AuthStudent(
              data: await _studentRepository.me(token: token), token: token));
          break;
        case 'admin':
          emit(AuthAdmin(
              data: await _authRepository.me(token: token), token: token));
          break;
        default:
          throw Exception('Role tidak dikenal: $role');
      }
    } catch (e, s) {
      debugPrint('Error: $e, Stack Trace: $s');
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _logout(LogoutAuth event, Emitter<AuthState> emit) async {
    event.context.go(RouteNames.login);
    await Future.delayed(const Duration(seconds: 1));
    emit(const AuthNotauthenticated());
  }
}
