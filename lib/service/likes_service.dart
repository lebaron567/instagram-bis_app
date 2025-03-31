import 'dart:convert';
import 'package:http/http.dart' as http;

class LikeService {
  final String baseUrl;

  LikeService({required this.baseUrl});

  Future<http.Response> likePost(int postId, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts/$postId/like'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'userId': userId,
      }),
    );
    return response;
  }

  Future<http.Response> unlikePost(int postId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/posts/$postId/like'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
}
