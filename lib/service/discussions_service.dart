import 'dart:convert';
import 'package:http/http.dart' as http;


class DiscussionService {
  final String baseUrl;

  DiscussionService({required this.baseUrl});

  Future<http.Response> createDiscussion(int userId, String title, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/discussions'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userId,
        'title': title,
        'content': content,
      }),
    );
    return response;
  }

  Future<http.Response> getDiscussionsByUser(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$userId/discussions'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<http.Response> deleteDiscussion(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/discussions/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
}
