import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';
import '../config/api.dart';

class CommentsService {
  final String baseUrl;

  CommentsService({this.baseUrl = ApiConfig.baseUrl});

  Future<bool> addComment(String postId, String userId, String content) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts/$postId/comments'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'content': content,
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      log('Erreur addComment: $e');
      return false;
    }
  }

  Future<List<dynamic>> getComments(String postId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/$postId/comments'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        log('Erreur getComments: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Exception getComments: $e');
      return [];
    }
  }

  Future<bool> deleteComment(String commentId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/comments/$commentId'),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 204;
    } catch (e) {
      log('Erreur deleteComment: $e');
      return false;
    }
  }
}
