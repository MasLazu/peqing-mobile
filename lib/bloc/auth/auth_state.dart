part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class Notauthenticated extends AuthState {
  const Notauthenticated();
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

final class Authenticated extends AuthState {
  final Auth auth;

  const Authenticated({
    required this.auth,
  });
}
