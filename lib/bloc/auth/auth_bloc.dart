import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/material.dart';
import 'package:peqing/data/models/auth.dart';
import 'package:peqing/data/repositories/auth_repository.dart';
import 'package:peqing/route/route_names.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  late AuthRepository _authRepository;

  AuthBloc() : super(const Notauthenticated()) {
    on<LoginAuth>(_login);
    on<LogoutAuth>(_logout);
  }

  void setAuthRepository(AuthRepository authRepository) {
    _authRepository = authRepository;
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
      final token = await _authRepository.login(event.id, event.password);
      final user = await _authRepository.me(token: token);
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
