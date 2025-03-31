import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<http.Response> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    return response;
  }

  Future<http.Response> signUp(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    return response;
  }

  // Ajoutez d'autres méthodes pour interagir avec votre API

  //createPost (String userId, String content, String imageUrl)
  //getPosts()
  //getPostById(String postId)
  //deletePost(String postId)
  //addComment(String postId, String userId, String content)
  //getComments(String postId)
  //deleteComment(String commentId)
}