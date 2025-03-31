import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const baseUrl = 'http://localhost:8080/api/v1/users';

  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Sauvegarde le token dans le localStorage ici
      return true;
    }
    return false;
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
