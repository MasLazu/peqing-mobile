import 'dart:convert';
import 'package:peqing/data/models/users/user.dart';

class Student extends User {
  final String departerment;
  final String major;
  final String nrp;
  final String qrLink;

  Student({
    required super.id,
    required super.name,
    required super.email,
    required this.departerment,
    required this.major,
    required this.nrp,
    required this.qrLink,
  });

  @override
  get role => 'Mahasiswa';

  @override
  Student copyWith({
    int? id,
    String? name,
    String? email,
    String? departerment,
    String? major,
    String? nrp,
    String? qrLink,
  }) {
    return Student(
      id: id ?? super.id,
      name: name ?? super.name,
      email: email ?? super.email,
      departerment: departerment ?? this.departerment,
      major: major ?? this.major,
      nrp: nrp ?? this.nrp,
      qrLink: qrLink ?? this.qrLink,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': super.id,
      'departerment': departerment,
      'major': major,
      'nrp': nrp,
      'qrLink': qrLink,
      'user': super.toMap(),
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as int,
      email: map['user']['email'] as String,
      name: map['user']['name'] as String,
      departerment: map['departerment'] as String,
      major: map['major'] as String,
      nrp: map['nrp'] as String,
      qrLink: map['qrLink'] as String,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(departerment: $departerment, major: $major, nrp: $nrp, qrLink: $qrLink, id: $id, name: $name, email: $email)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.departerment == departerment &&
        other.major == major &&
        other.nrp == nrp &&
        other.qrLink == qrLink &&
        other.id == id &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode {
    return departerment.hashCode ^
        major.hashCode ^
        nrp.hashCode ^
        qrLink.hashCode ^
        id.hashCode ^
        name.hashCode ^
        email.hashCode;
  }
}
