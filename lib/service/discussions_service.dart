import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/config/api.dart';

class DiscussionService {
  final String baseUrl;

  DiscussionService({this.baseUrl = ApiConfig.baseUrl});

  Future<bool> createDiscussion(int userId, String title, String content) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/discussions'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'title': title,
          'content': content,
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      log('Erreur createDiscussion: $e');
      return false;
    }
  }

  Future<List<dynamic>> getDiscussionsByUser(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$userId/discussions'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      log('Erreur getDiscussionsByUser: ${response.statusCode}');
      return [];
    } catch (e) {
      log('Exception getDiscussionsByUser: $e');
      return [];
    }
  }

  Future<bool> deleteDiscussion(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/discussions/$id'),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 204;
    } catch (e) {
      log('Erreur deleteDiscussion: $e');
      return false;
    }
  }
}
