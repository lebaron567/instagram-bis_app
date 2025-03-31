import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:your_app/utils/token_storage.dart';

class AuthService {
  static const baseUrl = 'http://localhost:8080/api/v1/users';

  static Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return "fake_token"; // ou un userId si dispo
    }

    return null;
  }

  static Future<bool> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    return response.statusCode == 201;
  }
}
