import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../config/api.dart';

class PostsService {
  final String baseUrl;

  PostsService({this.baseUrl = ApiConfig.baseUrl});

  Future<bool> createPost(String userId, String content, String imageUrl) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'content': content,
          'imageUrl': imageUrl,
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      log('Erreur createPost: $e');
      return false;
    }
  }

  Future<List<dynamic>> getPosts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/feed'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      log('Erreur getPosts: ${response.statusCode}');
      return [];
    } catch (e) {
      log('Exception getPosts: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getPostById(String postId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/$postId'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      log('Erreur getPostById: ${response.statusCode}');
      return null;
    } catch (e) {
      log('Exception getPostById: $e');
      return null;
    }
  }

  Future<bool> deletePost(String postId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/posts/$postId'),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 204;
    } catch (e) {
      log('Erreur deletePost: $e');
      return false;
    }
  }
}
