import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/config/api.dart';

class LikeService {
  final String baseUrl;

  LikeService({this.baseUrl = ApiConfig.baseUrl});

  Future<bool> likePost(int postId, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/like/$postId/like'),
        headers: {
          'Content-Type': 'application/json',
          'User-ID': userId.toString(), // conforme au Swagger
        },
      );
      return response.statusCode == 201;
    } catch (e) {
      log('Erreur likePost: $e');
      return false;
    }
  }

  Future<bool> unlikePost(int postId, int userId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/like/$postId/like'),
        headers: {
          'Content-Type': 'application/json',
          'User-ID': userId.toString(),
        },
      );
      return response.statusCode == 204;
    } catch (e) {
      log('Erreur unlikePost: $e');
      return false;
    }
  }
}
