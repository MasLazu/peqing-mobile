import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peqing/bloc/auth/auth_bloc.dart';

class Repository {
  final String baseUrl;
  final AuthBloc authBloc;

  Repository(String prefix, this.authBloc)
      : baseUrl = 'http://localhost:300$prefix';

  Future<Map<String, dynamic>> get(String path) async {
    final url = Uri.parse('$baseUrl$path');
    final response = await http.get(url, headers: _getHeaders());

    _checkResponse(response);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> post(String path,
      {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$path');
    final response = await http.post(url, headers: _getHeaders(), body: body);

    _checkResponse(response);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> put(String path,
      {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$path');
    final response = await http.put(url, headers: _getHeaders(), body: body);

    _checkResponse(response);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> delete(String path) async {
    final url = Uri.parse('$baseUrl$path');
    final response = await http.delete(url, headers: _getHeaders());

    _checkResponse(response);

    return jsonDecode(response.body);
  }

  void _checkResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Map<String, String> _getHeaders() {
    final state = authBloc.state;

    if (state is Authenticated) {
      return {
        'Authorization': 'Bearer ${state.auth.token}',
      };
    }

    return {};
  }
}
