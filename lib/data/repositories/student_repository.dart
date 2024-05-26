import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/users/student.dart';
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

  Future<String> createOne(Student student) async {
    final response = await post(body: {
      'name': student.name,
      'email': student.email,
      'password': student.password,
      'nrp': student.nrp,
      'jurusan': student.major,
      'departement': student.departerment,
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

  // Future<String> updateOne(Student student) async {
  //   final response = await put(path: '/${student.id}', body: {
  //     'name': student.name,
  //     'email': student.email,
  //     'password': student.password,
  //     'nrp': student.nrp,
  //     'jurusan': student.major,
  //     'departement': student.departerment,
  //   });

  //   return response['message'];
  // }
}
