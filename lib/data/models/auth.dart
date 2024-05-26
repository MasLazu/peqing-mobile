import 'dart:convert';
import 'package:peqing/data/models/users/lecturer.dart';
import 'package:peqing/data/models/users/student.dart';
import 'package:peqing/data/models/users/user.dart';

class Auth {
  final String token;
  final User user;

  Auth({
    required this.token,
    required this.user,
  });

  Auth copyWith({
    String? token,
    User? user,
  }) {
    return Auth(
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'user': user.toMap(),
    };
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    if (map['user']['nip'] != null) {
      return Auth(
        token: map['token'] as String,
        user: Lecturer.fromMap(map['user'] as Map<String, dynamic>),
      );
    }
    if (map['user']['nrp'] != null) {
      return Auth(
        token: map['token'] as String,
        user: Student.fromMap(map['user'] as Map<String, dynamic>),
      );
    }
    return Auth(
      token: map['token'] as String,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Auth.fromJson(String source) =>
      Auth.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Auth(token: $token, user: $user)';

  @override
  bool operator ==(covariant Auth other) {
    if (identical(this, other)) return true;

    return other.token == token && other.user == user;
  }

  @override
  int get hashCode => token.hashCode ^ user.hashCode;
}
