import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:peqing/data/models/lecturer.dart';
import 'package:peqing/data/models/subject.dart';

class Class {
  final int? id;
  final String name;
  List<Subject>? subjects;
  final Lecturer lecturer;

  Class({
    this.id,
    required this.name,
    this.subjects,
    required this.lecturer,
  });

  Class copyWith({
    int? id,
    String? name,
    List<Subject>? subjects,
    Lecturer? lecturer,
  }) {
    return Class(
      id: id ?? this.id,
      name: name ?? this.name,
      subjects: subjects ?? this.subjects,
      lecturer: lecturer ?? this.lecturer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'subjects': subjects?.map((x) => x.toMap()).toList(),
      'lecturer': lecturer.toMap(),
    };
  }

  factory Class.fromMap(Map<String, dynamic> map) {
    return Class(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      subjects: List<Subject>.from((map['subjects'] as List? ?? [])
          .map((x) => Subject.fromMap(x as Map<String, dynamic>))),
      lecturer: Lecturer.fromMap(map['lecturer'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Class.fromJson(String source) =>
      Class.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Class(id: $id, name: $name, subjects: $subjects, lecturer: $lecturer)';
  }

  @override
  bool operator ==(covariant Class other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.subjects, subjects) &&
        other.lecturer == lecturer;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ subjects.hashCode ^ lecturer.hashCode;
  }
}
