import 'dart:convert';
import 'package:http/http.dart' as http;

class PostsServices {
  final String baseUrl;

  PostsServices({required this.baseUrl});


  Future<http.Response> createPost(String userId, String content, String imageUrl) async {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
          'content': content,
          'imageUrl': imageUrl,
        }),
      );
      return response;
    }

  Future<http.Response> getPosts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts/feed'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<http.Response> getPostById(String postId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts/$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<http.Response> deletePost(String postId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/posts/$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
}