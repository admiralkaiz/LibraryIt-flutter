import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:libraryit/models/review.dart';
import 'url.dart';

class ReviewApi {
  final String reviewUrl = '$apiUrl/reviews';
  final String token;

  const ReviewApi({
    required this.token,
  });

  factory ReviewApi.newFromToken(String token) => ReviewApi(token: token);

  Future<Map<String, dynamic>> getAllPosts() async {
    final response = await http.get(
      Uri.parse(reviewUrl),
      headers: {
        HttpHeaders.authorizationHeader: token
      }
    );
    final isOk = response.statusCode == 200;
    return {
      'status': isOk,
      'data': isOk ? (jsonDecode(response.body) as List).map((review) => Review.fromJson(review)).toList() : {},
      'message': isOk ? 'Successfully loaded reviews!' : 'Failed to load reviews!',
    };
  }

  Future<Map<String, dynamic>> getReviewById(int id) async {
    final response = await http.get(
      Uri.parse('$reviewUrl/$id'),
      headers: {
        HttpHeaders.authorizationHeader: token
      }
    );
    final jsonResponse = jsonDecode(response.body);

    Map<String, dynamic> result = <String, dynamic>{};
    result['status'] = jsonResponse['status'];
    result['message'] = jsonResponse['message'];
    result['data'] = response.statusCode == 200 ? Review.fromJson(jsonResponse['data'] as Map<String, dynamic>) : {};
    return result;
  }

  Future<Map<String, dynamic>> insertReview(int bookId, String title, String description) async {
    final http.Response response = await http.post(
      Uri.parse(reviewUrl),
      headers: <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded',
        HttpHeaders.authorizationHeader: token
      },
      body: <String, dynamic> {
        'book_id': bookId,
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

  Future<Map<String, dynamic>> updateReview(int id, String title, String description) async {
    final response = await http.put(
      Uri.parse('$reviewUrl/$id'),
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

  Future<Map<String, dynamic>> deleteReview(int id) async {
    final response = await http.delete(
      Uri.parse('$reviewUrl/$id'),
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