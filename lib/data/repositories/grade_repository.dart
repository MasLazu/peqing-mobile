import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/grade.dart';
import 'package:peqing/data/repositories/repository.dart';

class GradeRepository extends Repository {
  GradeRepository(AuthBloc authBloc) : super('/nilai', authBloc);

  Future<void> create(
      int score, int studentId, int gradeTypeId, int subjectId) async {
    await post(path: '/$subjectId', body: {
      'nilai': score,
      'mahasiswaId': studentId,
      'typenilaiId': gradeTypeId,
    });
  }

  Future<List<Grade>> getByStudentIdAndSubjectId(
      int studentId, int subjectId) async {
    final response = await get(path: '/$subjectId/$studentId');

    return (response['message'] as List).map((e) => Grade.fromMap(e)).toList();
  }

  Future<List<Grade>> getBySubjectId(int subjectId) async {
    final response = await get(path: '/$subjectId');

    return (response['message'] as List).map((e) => Grade.fromMap(e)).toList();
  }

  Future<void> update(Grade grade, String subjectId) async {
    await put(path: '/$subjectId/${grade.id}', body: grade.toMap());
  }

  Future<void> deleteById(int id) async {
    await delete(path: '/$id');
  }
}
