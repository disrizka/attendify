import 'dart:convert';
import 'package:attendify/api/endpoint.dart';
import 'package:attendify/pages/auth/models/login_model.dart';
import 'package:attendify/pages/auth/models/register_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<RegisterResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${Endpoint.baseUrlApi}/register'),
      headers: {'Accept': 'application/json'},
      body: {'name': name, 'email': email, 'password': password},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Gagal registrasi: ${jsonDecode(response.body)['message']}',
      );
    }
  }

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${Endpoint.baseUrlApi}/login'),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['message'] ?? 'Login gagal');
    }
  }
}
