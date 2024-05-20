import 'package:peqing/data/models/users/user.dart';

class Lecturer extends User {
  final String nip;

  Lecturer({
    required super.id,
    required super.name,
    required super.email,
    required this.nip,
  });

  @override
  get role => 'Dosen';

  @override
  Lecturer copyWith({
    int? id,
    String? name,
    String? email,
    String? nip,
  }) {
    return Lecturer(
      id: id ?? super.id,
      name: name ?? super.name,
      email: email ?? super.email,
      nip: nip ?? this.nip,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': super.id,
      'nip': nip,
      'user': super.toMap(),
    };
  }

  factory Lecturer.fromMap(Map<String, dynamic> map) {
    return Lecturer(
      id: map['id'] as int,
      email: map['user']['email'] as String,
      name: map['user']['name'] as String,
      nip: map['nip'] as String,
    );
  }

  @override
  String toString() =>
      'Lecturer(id: $id, name: $name, email: $email, nip: $nip)';

  @override
  bool operator ==(covariant Lecturer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.nip == nip;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ nip.hashCode;
}
