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
        // 📌 Sauvegarder les infos de l'utilisateur localement
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(userData));
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
}
