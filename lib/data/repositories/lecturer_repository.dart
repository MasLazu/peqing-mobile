import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/users/lecturer.dart';
import 'package:peqing/data/repositories/repository.dart';

class LecturerRepository extends Repository {
  LecturerRepository({required AuthBloc authBloc}) : super('/dosen', authBloc);

  Future<Lecturer> me({String? token}) async {
    final response = await get('/me', header: {
      'Authorization': 'Bearer $token',
    });
    return Lecturer.fromMap(response['message']);
  }
}
