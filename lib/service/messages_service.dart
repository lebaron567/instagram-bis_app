import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/config/api.dart';

class MessageService {
  final String baseUrl;

  MessageService({this.baseUrl = ApiConfig.baseUrl});

  Future<bool> createMessage(int discussionId, int userId, String content) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/discussions/$discussionId/messages'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'content': content,
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      log('Erreur createMessage: $e');
      return false;
    }
  }

  Future<List<dynamic>> getMessages(int discussionId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/discussions/$discussionId/messages'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      log('Erreur getMessages: ${response.statusCode}');
      return [];
    } catch (e) {
      log('Exception getMessages: $e');
      return [];
    }
  }

  Future<bool> updateMessage(int id, String content) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/messages/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'content': content}),
      );
      return response.statusCode == 200;
    } catch (e) {
      log('Erreur updateMessage: $e');
      return false;
    }
  }

  Future<bool> deleteMessage(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/messages/$id'),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 204;
    } catch (e) {
      log('Erreur deleteMessage: $e');
      return false;
    }
  }
}
