import 'dart:convert';

class GradeType {
  final int? id;
  final String name;
  final int classId;

  GradeType({
    this.id,
    required this.name,
    required this.classId,
  });

  GradeType copyWith({
    int? id,
    String? name,
    int? classId,
  }) {
    return GradeType(
      id: id ?? this.id,
      name: name ?? this.name,
      classId: classId ?? this.classId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'kelasId': classId,
    };
  }

  factory GradeType.fromMap(Map<String, dynamic> map) {
    return GradeType(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      classId: map['kelasId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GradeType.fromJson(String source) =>
      GradeType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GradeType(id: $id, name: $name, classId: $classId)';

  @override
  bool operator ==(covariant GradeType other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.classId == classId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ classId.hashCode;
}
