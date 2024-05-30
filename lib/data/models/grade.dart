import 'dart:convert';

class Grade {
  final int? id;
  final String? grade;
  final int classId;
  final int score;

  Grade({
    this.id,
    this.grade,
    required this.classId,
    required this.score,
  });

  Grade copyWith({
    int? id,
    String? grade,
    int? classId,
    int? score,
  }) {
    return Grade(
      id: id ?? this.id,
      grade: grade ?? this.grade,
      classId: classId ?? this.classId,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'grade': grade,
      'kelasId': classId,
      'nilai': score,
    };
  }

  factory Grade.fromMap(Map<String, dynamic> map) {
    return Grade(
      id: map['id'] != null ? map['id'] as int : null,
      grade: map['grade'] != null ? map['grade'] as String : null,
      classId: map['kelasId'] as int,
      score: map['nilai'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Grade.fromJson(String source) =>
      Grade.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Grade(id: $id, grade: $grade, classId: $classId, score: $score)';
  }

  @override
  bool operator ==(covariant Grade other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.grade == grade &&
        other.classId == classId &&
        other.score == score;
  }

  @override
  int get hashCode {
    return id.hashCode ^ grade.hashCode ^ classId.hashCode ^ score.hashCode;
  }
}
