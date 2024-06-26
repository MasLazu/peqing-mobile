import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/lecturer.dart';
import 'package:peqing/data/repositories/repository.dart';

class LecturerRepository extends Repository {
  LecturerRepository({required AuthBloc authBloc}) : super('/dosen', authBloc);

  Future<Lecturer> me({String? token}) async {
    final response = await get(path: '/me', header: {
      'Authorization': 'Bearer $token',
    });
    return Lecturer.fromMap(response['message']);
  }

  Future<String> create(Lecturer lecturer) async {
    final response = await post(body: {
      'name': lecturer.user!.name,
      'email': lecturer.user!.email,
      'password': lecturer.user!.password,
      'nip': lecturer.nip,
    });

    return response['message'];
  }

  Future<List<Lecturer>> getAll() async {
    final response = await get();

    return (response['message'] as List)
        .map((e) => Lecturer.fromMap(e))
        .toList();
  }

  Future<Lecturer> getById(int id) async {
    final response = await get(path: '/$id');

    return Lecturer.fromMap(response['message']);
  }

  Future<void> update(Lecturer lecturer) async {
    await put(path: '/${lecturer.id}', body: lecturer.toMap());
  }

  Future<void> deleteById(int id) async {
    await delete(path: '/$id');
  }
}
