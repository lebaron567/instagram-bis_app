import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const baseUrl = 'http://localhost:8080/api/v1/users';

  // 📌 Enregistrer l'utilisateur après inscription
  static Future<bool> register(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        final userJson =
            jsonDecode(response.body); // <- réponse réelle du backend
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'user', jsonEncode(userJson)); // <- sauvegarde vraie réponse
        return true;
      }
      return false;
    } catch (e) {
      print('Erreur inscription: $e');
      return false;
    }
  }

  // 📌 Récupérer les infos de l'utilisateur stockées localement
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  static Future<bool> login(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(data)); // sauvegarde l'utilisateur

      return true;
    }

    return false;
  } catch (e) {
    print('Erreur login: $e');
    return false;
  }
}

} 
