import 'dart:convert';
import 'package:http/http.dart' as http;

class CommentsServices {
  final String baseUrl;

  CommentsServices({required this.baseUrl});

  Future<http.Response> addComment(String postId, String userId, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts/$postId/comments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
        'content': content,
      }),
    );
    return response;
  }

  Future<http.Response> getComments(String postId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts/$postId/comments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<http.Response> deleteComment(String commentId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/comments/$commentId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

}