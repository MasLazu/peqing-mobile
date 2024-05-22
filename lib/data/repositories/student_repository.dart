import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/users/student.dart';
import 'package:peqing/data/repositories/repository.dart';

class StudentRepository extends Repository {
  StudentRepository({required AuthBloc authBloc})
      : super('/mahasiswa', authBloc);

  Future<Student> me({String? token}) async {
    final response = await get('/me', header: {
      'Authorization': 'Bearer $token',
    });
    return Student.fromMap(response['message']);
  }
}
