import 'dart:convert';
import 'package:peqing/data/models/users/user.dart';

class Student extends User {
  final String departement;
  final String major;
  final String nrp;
  final String? qrLink;

  Student({
    super.id,
    required super.name,
    required super.email,
    super.password,
    required this.departement,
    required this.major,
    required this.nrp,
    this.qrLink,
  });

  @override
  get role => 'Mahasiswa';

  @override
  Student copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? departement,
    String? major,
    String? nrp,
    String? qrLink,
  }) {
    return Student(
      id: id ?? super.id,
      name: name ?? super.name,
      email: email ?? super.email,
      password: password ?? super.password,
      departement: departement ?? this.departement,
      major: major ?? this.major,
      nrp: nrp ?? this.nrp,
      qrLink: qrLink ?? this.qrLink,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': super.id,
      'departement': departement,
      'jurusan': major,
      'nrp': nrp,
      'qr': qrLink,
      'user': super.toMap(),
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as int,
      email: map['user']['email'] as String,
      name: map['user']['name'] as String,
      password: map['user']['password'] as String?,
      departement: map['departement'] as String,
      major: map['jurusan'] as String,
      nrp: map['nrp'] as String,
      qrLink: map['qr'] as String,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(departement: $departement, major: $major, nrp: $nrp, qrLink: $qrLink, id: $id, name: $name, email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.departement == departement &&
        other.major == major &&
        other.nrp == nrp &&
        other.qrLink == qrLink &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return departement.hashCode ^
        major.hashCode ^
        nrp.hashCode ^
        qrLink.hashCode ^
        id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode;
  }
}
