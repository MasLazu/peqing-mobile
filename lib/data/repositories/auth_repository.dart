import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/user.dart';
import 'package:peqing/data/repositories/repository.dart';

class AuthRepository extends Repository {
  AuthRepository({required AuthBloc authBloc}) : super('/auth', authBloc);

  Future<String> login(String id, String password) async {
    final response = await post('/login', body: {
      'id': id,
      'password': password,
    });

    return response['data']['token'];
  }

  Future<User> me() async {
    final response = await get('/me');
    return User.fromMap(response['data']);
  }
}
