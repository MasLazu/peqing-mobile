import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/material.dart';
import 'package:peqing/data/models/auth.dart';
import 'package:peqing/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  late AuthRepository _authRepository;

  AuthBloc() : super(const Notauthenticated()) {
    on<LoginAuth>(_login);
  }

  void setAuthRepository(AuthRepository authRepository) {
    _authRepository = authRepository;
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    try {
      print(json);
      return Authenticated(auth: Auth.fromMap(json));
    } catch (_) {
      print('error');
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

  void _login(LoginAuth event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final token = await _authRepository.login(event.id, event.password);
      final user = await _authRepository.me(token: token);
      emit(Authenticated(auth: Auth(token: token, user: user)));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
