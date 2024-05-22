import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/material.dart';
import 'package:peqing/data/models/auth.dart';
import 'package:peqing/data/models/users/user.dart';
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

  AuthBloc() : super(const Notauthenticated()) {
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
    try {
      // throw Exception();
      return Authenticated(auth: Auth.fromMap(json));
    } catch (_) {
      return const Notauthenticated();
    }
  }

  @override
  Map<String, dynamic> toJson(AuthState state) {
    if (state is Authenticated) {
      return state.auth.toMap();
    }
    return {};
  }

  Future<void> _login(LoginAuth event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final res = await _authRepository.login(event.id, event.password);
      final token = res['token']!;
      final role = res['role']!;
      late User user;
      switch (role) {
        case 'dosen':
          user = await _lecturerRepository.me(token: token);
          break;
        case 'mahasiswa':
          user = await _studentRepository.me(token: token);
          break;
        case 'admin':
          user = await _authRepository.me(token: token);
          break;
        default:
          throw Exception('Role tidak dikenal: $role');
      }
      emit(Authenticated(auth: Auth(token: token, user: user)));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _logout(LogoutAuth event, Emitter<AuthState> emit) async {
    event.context.go(RouteNames.login);
    await Future.delayed(const Duration(seconds: 1));
    emit(const Notauthenticated());
  }
}
