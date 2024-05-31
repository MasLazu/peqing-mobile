import 'dart:convert';

class Grade {
  final int? id;
  final String grade;
  final int score;
  final int subjectId;
  final int gradeTypeId;

  Grade({
    this.id,
    required this.grade,
    required this.score,
    required this.subjectId,
    required this.gradeTypeId,
  });

  Grade copyWith({
    int? id,
    String? grade,
    int? score,
    int? subjectId,
    int? gradeTypeId,
  }) {
    return Grade(
      id: id ?? this.id,
      grade: grade ?? this.grade,
      score: score ?? this.score,
      subjectId: subjectId ?? this.subjectId,
      gradeTypeId: gradeTypeId ?? this.gradeTypeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'grade': grade,
      'score': score,
      'kelasId': subjectId,
      'typeNilai': {
        'id': gradeTypeId,
      },
    };
  }

  factory Grade.fromMap(Map<String, dynamic> map) {
    return Grade(
      id: map['id'] != null ? map['id'] as int : null,
      grade: map['grade'] as String,
      score: map['score'] as int,
      subjectId: map['kelasId'] as int,
      gradeTypeId: map['typeNilai']['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Grade.fromJson(String source) =>
      Grade.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Grade(id: $id, grade: $grade, score: $score, subjectId: $subjectId, gradeTypeId: $gradeTypeId)';
  }

  @override
  bool operator ==(covariant Grade other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.grade == grade &&
        other.score == score &&
        other.subjectId == subjectId &&
        other.gradeTypeId == gradeTypeId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        grade.hashCode ^
        score.hashCode ^
        subjectId.hashCode ^
        gradeTypeId.hashCode;
  }
}
