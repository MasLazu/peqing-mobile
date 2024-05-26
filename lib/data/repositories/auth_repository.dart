import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/user.dart';
import 'package:peqing/data/repositories/repository.dart';

class AuthRepository extends Repository {
  AuthRepository({required AuthBloc authBloc}) : super('/auth', authBloc);

  Future<Map<String, dynamic>> login(String id, String password) async {
    final response = await post(path: '/login', body: {
      'email': id,
      'password': password,
    });

    return response['message'];
  }

  Future<Map<String, dynamic>> register(User user) async {
    final response = await post(path: '/register', body: {
      'email': user.email,
      'password': user.password,
      'name': user.name,
    });

    return response['message'];
  }

  Future<User> me({String? token}) async {
    final response = await get(path: '/me', header: {
      'Authorization': 'Bearer $token',
    });
    return User.fromMap(response['message']);
  }
}
