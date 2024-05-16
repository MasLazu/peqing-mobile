part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class Notauthenticated extends AuthState {
  const Notauthenticated();
}

final class LoadingAuth extends AuthState {
  const LoadingAuth();
}

final class Authenticated extends AuthState {
  final Auth auth;

  const Authenticated({
    required this.auth,
  });
}
