import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/subject.dart';
import 'package:peqing/data/repositories/repository.dart';

class SubjectRepository extends Repository {
  SubjectRepository(AuthBloc authBloc) : super('/kelas', authBloc);

  Future<void> create(int lecturerId, String name) async {
    await post(body: {
      'name': name,
      'dosenId': lecturerId,
    });
  }

  Future<List<Subject>> getAll() async {
    final response = await get(path: '/dosen-matakuliah');

    return (response['message'] as List)
        .map((e) => Subject.fromMap(e))
        .toList();
  }

  Future<List<Subject>> getByLecturerId(int lecturerId) async {
    final response = await get(path: '/dosen/$lecturerId');

    return (response['message'] as List)
        .map((e) => Subject.fromMap(e))
        .toList();
  }

  Future<List<Subject>> getByLecturerIdAndStudentId(
      int lecturerId, int studentId) async {
    final response = await get(path: '/$lecturerId/$studentId');

    return (response['message'] as List)
        .map((e) => Subject.fromMap(e))
        .toList();
  }

  Future<Subject> getById(int id) async {
    final response = await get(path: '/dosen-matakuliah/$id');

    return Subject.fromMap(response['message']);
  }

  Future<void> update(Subject subject) async {
    await put(path: '/${subject.id}', body: subject.toMap());
  }

  Future<void> deleteById(int id) async {
    await delete(path: '/$id');
  }
}
