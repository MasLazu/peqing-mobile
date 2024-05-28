import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/student.dart';
import 'package:peqing/data/repositories/repository.dart';

class StudentRepository extends Repository {
  StudentRepository({required AuthBloc authBloc})
      : super('/mahasiswa', authBloc);

  Future<Student> me({String? token}) async {
    final response = await get(path: '/me', header: {
      'Authorization': 'Bearer $token',
    });
    return Student.fromMap(response['message']);
  }

  Future<String> create(Student student) async {
    final response = await post(body: {
      'name': student.user.name,
      'email': student.user.email,
      'password': student.user.password,
      'nrp': student.nrp,
      'jurusan': student.major,
      'departement': student.departement,
    });
    return response['message'];
  }

  Future<List<Student>> getAll() async {
    final response = await get();

    return (response['message'] as List)
        .map((e) => Student.fromMap(e))
        .toList();
  }

  Future<Student> getById(int id) async {
    final response = await get(path: '/$id');

    return Student.fromMap(response['message']);
  }

  Future<void> update(Student student) async {
    print(student);
    await put(path: '/${student.id}', body: student.toMap());
  }

  Future<void> deleteById(int id) async {
    await delete(path: '/$id');
  }
}
