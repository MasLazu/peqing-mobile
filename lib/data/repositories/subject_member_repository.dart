import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/student.dart';
import 'package:peqing/data/repositories/repository.dart';

class SubjectMemberRepository extends Repository {
  SubjectMemberRepository(AuthBloc authBloc) : super('/anggota', authBloc);

  Future<void> create(int subjectId, int studentId) async {
    await post(body: {
      'mahasiswaId': studentId,
      'kelasId': subjectId,
    });
  }

  Future<List<Student>> getBySubjectId(int subjectId) async {
    final response = await get(path: '/$subjectId');

    return (response['message'] as List)
        .map((e) => Student.fromMap(e['mahasiswa']))
        .toList();
  }

  Future<int> findIdBySubjectIdAndStudentId(
      int subjectId, int studentId) async {
    final response = await get(path: '/$subjectId/$studentId');

    return response['message']['id'];
  }

  Future<void> deleteById(int id) async {
    await delete(path: '/$id');
  }
}
