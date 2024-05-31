import 'dart:convert';
import 'package:peqing/data/models/lecturer.dart';

class Subject {
  final int? id;
  final String name;
  final Lecturer? lecturer;

  Subject({
    this.id,
    required this.name,
    this.lecturer,
  });

  Subject copyWith({
    int? id,
    String? name,
    Lecturer? lecturer,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      lecturer: lecturer ?? this.lecturer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'dosen': lecturer?.toMap(),
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      lecturer: map['dosen'] != null
          ? Lecturer.fromMap(map['dosen'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Subject.fromJson(String source) =>
      Subject.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Subject(id: $id, name: $name, lecturer: $lecturer)';

  @override
  bool operator ==(covariant Subject other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.lecturer == lecturer;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ lecturer.hashCode;
}
