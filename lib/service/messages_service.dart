import 'dart:convert';
import 'package:http/http.dart' as http;


class MessageService {
  final String baseUrl;

  MessageService({required this.baseUrl});

  Future<http.Response> createMessage(int discussionId, int userId, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/discussions/$discussionId/messages'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userId,
        'content': content,
      }),
    );
    return response;
  }

  Future<http.Response> getMessages(int discussionId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/discussions/$discussionId/messages'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<http.Response> updateMessage(int id, String content) async {
    final response = await http.put(
      Uri.parse('$baseUrl/messages/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'content': content,
      }),
    );
    return response;
  }

  Future<http.Response> deleteMessage(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/messages/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
}
