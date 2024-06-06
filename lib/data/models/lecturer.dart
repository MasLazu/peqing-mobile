import 'dart:convert';
import 'package:peqing/data/models/role.dart';
import 'package:peqing/data/models/user.dart';

class Lecturer extends Role {
  final int? id;
  final String nip;
  @override
  final User? user;

  Lecturer({
    this.id,
    required this.nip,
    required this.user,
  });

  @override
  get role => 'Dosen';

  Lecturer copyWith({
    int? id,
    String? nip,
    User? user,
  }) {
    return Lecturer(
      id: id ?? this.id,
      nip: nip ?? this.nip,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nip': nip,
      'user': user?.toMap(),
    };
  }

  factory Lecturer.fromMap(Map<String, dynamic> map) {
    return Lecturer(
      id: map['id'] != null ? map['id'] as int : null,
      nip: map['nip'] as String,
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lecturer.fromJson(String source) =>
      Lecturer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Lecturer(id: $id, nip: $nip, user: $user)';

  @override
  bool operator ==(covariant Lecturer other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nip == nip && other.user == user;
  }

  @override
  int get hashCode => id.hashCode ^ nip.hashCode ^ user.hashCode;
}
