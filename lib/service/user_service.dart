import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/config/api.dart';

class UserService {
  final String baseUrl;

  UserService({this.baseUrl = ApiConfig.baseUrl});

  Future<Map<String, dynamic>?> getUser(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$id'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      log('Erreur getUser: ${response.statusCode}');
      return null;
    } catch (e) {
      log('Exception getUser: $e');
      return null;
    }
  }

  Future<bool> updateUser(String id, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/users/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return response.statusCode == 200;
    } catch (e) {
      log('Exception updateUser: $e');
      return false;
    }
  }

  Future<bool> followUser(String id, String currentUserId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/$id/follow'),
        headers: {
          'Content-Type': 'application/json',
          'Current-User-ID': currentUserId
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      log('Exception followUser: $e');
      return false;
    }
  }

  Future<List<dynamic>> getFollowers(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$id/followers'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      log('Erreur getFollowers: ${response.statusCode}');
      return [];
    } catch (e) {
      log('Exception getFollowers: $e');
      return [];
    }
  }

  Future<List<dynamic>> getFollowing(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$id/following'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      log('Erreur getFollowing: ${response.statusCode}');
      return [];
    } catch (e) {
      log('Exception getFollowing: $e');
      return [];
    }
  }
}