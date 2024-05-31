import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/grade_type.dart';
import 'package:peqing/data/repositories/repository.dart';

class GradeTypeRepository extends Repository {
  GradeTypeRepository(AuthBloc authBloc) : super('/type-nilai', authBloc);

  Future<void> create(GradeType gradeType) async {
    await post(body: gradeType.toMap());
  }

  Future<List<GradeType>> getAll() async {
    final response = await get();

    return (response['message'] as List)
        .map((e) => GradeType.fromMap(e))
        .toList();
  }

  Future<List<GradeType>> getByKelasId(int id) async {
    final response = await get(path: '/kelas/$id');

    return (response['message'] as List)
        .map((e) => GradeType.fromMap(e))
        .toList();
  }

  Future<GradeType> getById(int id) async {
    final response = await get(path: '/$id');

    return GradeType.fromMap(response['message']);
  }

  Future<void> update(GradeType gradeType) async {
    await put(path: '/${gradeType.id}', body: gradeType.toMap());
  }

  Future<void> deleteById(int id) async {
    await delete(path: '/$id');
  }
}
