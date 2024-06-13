import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:libraryit/models/post.dart';
import 'url.dart';

class PostApi {
  final String postUrl = '$apiUrl/posts';
  final String token;

  const PostApi({
    required this.token,
  });

  factory PostApi.newFromToken(String token) => PostApi(token: token);

  Future<Map<String, dynamic>> getAllPosts() async {
    final response = await http.get(
      Uri.parse(postUrl),
      headers: {
        HttpHeaders.authorizationHeader: token
      }
    );
    final isOk = response.statusCode == 200;
    return {
      'status': isOk,
      'data': isOk ? (jsonDecode(response.body) as List).map((post) => Post.fromJson(post)).toList() : {},
      'message': isOk ? 'Successfully loaded posts!' : 'Failed to load posts!',
    };
  }

  Future<Map<String, dynamic>> getPostById(int id) async {
    final response = await http.get(
      Uri.parse('$postUrl/$id'),
      headers: {
        HttpHeaders.authorizationHeader: token
      }
    );
    final jsonResponse = jsonDecode(response.body);

    Map<String, dynamic> result = <String, dynamic>{};
    result['status'] = jsonResponse['status'];
    result['message'] = jsonResponse['message'];
    result['data'] = response.statusCode == 200 ? Post.fromJson(jsonResponse['data'] as Map<String, dynamic>) : {};
    return result;
  }

  Future<Map<String, dynamic>> insertPost(String title, String description) async {
    final http.Response response = await http.post(
      Uri.parse(postUrl),
      headers: <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded',
        HttpHeaders.authorizationHeader: token
      },
      body: <String, dynamic> {
        'title': title,
        'description': description,
      },
    );
    final responseJson = jsonDecode(response.body);
    return {
      'status': responseJson['status'],
      'message': responseJson['message'],
    };
  }

  Future<Map<String, dynamic>> updatePost(int id, String title, String description) async {
    final response = await http.put(
      Uri.parse('$postUrl/$id'),
      headers: <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded',
        HttpHeaders.authorizationHeader: token
      },
      body: <String, dynamic> {
        'title': title,
        'description': description,
      },
    );
    final responseJson = jsonDecode(response.body);
    return {
      'status': responseJson['status'],
      'message': responseJson['message'],
    };
  }

  Future<Map<String, dynamic>> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse('$postUrl/$id'),
      headers: {
        HttpHeaders.authorizationHeader: token
      }
    );
    final responseJson = jsonDecode(response.body);
    return {
      'status': responseJson['status'],
      'message': responseJson['message'],
    };
  }
}