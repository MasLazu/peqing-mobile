part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthNotauthenticated extends AuthState {
  const AuthNotauthenticated();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthError extends AuthState {
  final String message;

  const AuthError({
    required this.message,
  });
}

abstract class AuthAuthenticated extends AuthState {
  final String token;
  Map<String, dynamic> toMap();
  Role get data;

  const AuthAuthenticated({required this.token});
}

final class AuthAdmin extends AuthAuthenticated {
  @override
  final User data;

  @override
  Map<String, dynamic> toMap() => {
        'data': data.toMap(),
        'token': token,
      };

  const AuthAdmin({required this.data, required super.token});
}

final class AuthLecturer extends AuthAuthenticated {
  @override
  final Lecturer data;

  @override
  Map<String, dynamic> toMap() => {
        'data': data.toMap(),
        'token': token,
      };

  const AuthLecturer({required this.data, required super.token});
}

final class AuthStudent extends AuthAuthenticated {
  @override
  final Student data;

  @override
  Map<String, dynamic> toMap() => {
        'data': data.toMap(),
        'token': token,
      };

  const AuthStudent({required this.data, required super.token});
}
