part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class LoginAuth extends AuthEvent {
  final String id;
  final String password;

  const LoginAuth({
    required this.id,
    required this.password,
  });
}
