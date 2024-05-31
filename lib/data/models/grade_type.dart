import 'dart:convert';

class GradeType {
  final int? id;
  final String name;
  final int subjectId;

  GradeType({
    this.id,
    required this.name,
    required this.subjectId,
  });

  GradeType copyWith({
    int? id,
    String? name,
    int? subjectId,
  }) {
    return GradeType(
      id: id ?? this.id,
      name: name ?? this.name,
      subjectId: subjectId ?? this.subjectId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'kelasId': subjectId,
    };
  }

  factory GradeType.fromMap(Map<String, dynamic> map) {
    return GradeType(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      subjectId: map['kelasId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GradeType.fromJson(String source) =>
      GradeType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GradeType(id: $id, name: $name, subjectId: $subjectId)';

  @override
  bool operator ==(covariant GradeType other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.subjectId == subjectId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ subjectId.hashCode;
}
