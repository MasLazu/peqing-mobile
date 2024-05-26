import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peqing/bloc/auth/auth_bloc.dart';

class Repository {
  final Uri baseUrl;
  final AuthBloc authBloc;

  Repository(String prefix, this.authBloc)
      : baseUrl = Uri(
            scheme: 'https',
            host: '4phvhnt5-3001.asse.devtunnels.ms',
            path: prefix);

  Future<Map<String, dynamic>> get(
      {String path = '', Map<String, String>? header}) async {
    final url = baseUrl.replace(path: baseUrl.path + path);
    final response = await http.get(url, headers: _getHeaders(headers: header));

    _checkResponse(response);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> post(
      {String path = '', Map<String, dynamic>? body}) async {
    final url = baseUrl.replace(path: baseUrl.path + path);
    final response =
        await http.post(url, headers: _getHeaders(), body: jsonEncode(body));

    _checkResponse(response);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> put(
      {String path = '', Map<String, dynamic>? body}) async {
    final url = baseUrl.replace(path: baseUrl.path + path);
    final response =
        await http.put(url, headers: _getHeaders(), body: jsonEncode(body));

    _checkResponse(response);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> delete({String path = ''}) async {
    final url = baseUrl.replace(path: baseUrl.path + path);
    final response = await http.delete(url, headers: _getHeaders());

    _checkResponse(response);

    return jsonDecode(response.body);
  }

  void _checkResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Map<String, String> _getHeaders({Map<String, String>? headers}) {
    var state = authBloc.state;

    if (headers == null) {
      headers = {
        'Content-Type': 'application/json',
      };
    } else {
      headers['Content-Type'] = 'application/json';
    }

    if (state is Authenticated) {
      headers['Authorization'] = 'Bearer ${state.auth.token}';
    }

    debugPrint(
      '''
      =============================================
      request header: ${headers.toString()}
      =============================================
      ''',
    );

    return headers;
  }
}
