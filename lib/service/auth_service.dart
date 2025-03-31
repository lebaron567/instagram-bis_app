import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class AuthService {
  static const baseUrl = 'http://localhost:8080/api/v1/users';

  static Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['user_id'].toString(); // simulate token
      }

      log('Login failed: ${response.statusCode}');
      return null;
    } catch (e) {
      log('Exception login: $e');
      return null;
    }
  }

  static Future<bool> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      return response.statusCode == 201;
    } catch (e) {
      log('Exception register: $e');
      return false;
    }
  }
}
