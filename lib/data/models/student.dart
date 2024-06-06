import 'dart:convert';
import 'package:peqing/data/models/role.dart';
import 'package:peqing/data/models/user.dart';

class Student extends Role {
  final String departement;
  final String major;
  final String nrp;
  final String? qrLink;
  final int? id;
  @override
  final User? user;

  Student({
    required this.departement,
    required this.major,
    required this.nrp,
    this.qrLink,
    this.id,
    required this.user,
  });

  @override
  get role => 'Mahasiswa';

  Student copyWith({
    String? departement,
    String? major,
    String? nrp,
    String? qrLink,
    int? id,
    User? user,
  }) {
    return Student(
      departement: departement ?? this.departement,
      major: major ?? this.major,
      nrp: nrp ?? this.nrp,
      qrLink: qrLink ?? this.qrLink,
      id: id ?? this.id,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'departement': departement,
      'jurusan': major,
      'nrp': nrp,
      'qr': qrLink,
      'id': id,
      'user': user?.toMap(),
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      departement: map['departement'] as String,
      major: map['jurusan'] as String,
      nrp: map['nrp'] as String,
      qrLink: map['qr'] != null ? map['qr'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(departement: $departement, major: $major, nrp: $nrp, qrLink: $qrLink, id: $id, user: $user)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.departement == departement &&
        other.major == major &&
        other.nrp == nrp &&
        other.qrLink == qrLink &&
        other.id == id &&
        other.user == user;
  }

  @override
  int get hashCode {
    return departement.hashCode ^
        major.hashCode ^
        nrp.hashCode ^
        qrLink.hashCode ^
        id.hashCode ^
        user.hashCode;
  }
}
