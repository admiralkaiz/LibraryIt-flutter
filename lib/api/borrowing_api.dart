import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:libraryit/models/borrowing.dart';
import 'url.dart';

class BorrowingApi {
  final String borrowingUrl = '$apiUrl/borrowings';
  final String token;

  const BorrowingApi({
    required this.token,
  });

  factory BorrowingApi.newFromToken(String token) => BorrowingApi(token: token);

  Future<Map<String, dynamic>> getAllBorrowings() async {
    final response = await http.get(
      Uri.parse(borrowingUrl),
      headers: {
        HttpHeaders.authorizationHeader: token
      }
    );
    final isOk = response.statusCode == 200;
    return {
      'status': isOk,
      'data': isOk ? (jsonDecode(response.body) as List).map((b) => Borrowing.fromJson(b)).toList() : {},
      'message': isOk ? 'Successfully loaded borrowings!' : 'Failed to load borrowings!',
    };
  }

  Future<Map<String, dynamic>> getBorrowingById(int id) async {
    final response = await http.get(
      Uri.parse('$borrowingUrl/$id'),
      headers: {
        HttpHeaders.authorizationHeader: token
      }
    );
    final jsonResponse = jsonDecode(response.body);

    Map<String, dynamic> result = <String, dynamic>{};
    result['status'] = jsonResponse['status'];
    result['message'] = jsonResponse['message'];
    result['data'] = response.statusCode == 200 ? Borrowing.fromJson(jsonResponse['data'] as Map<String, dynamic>) : {};
    return result;
  }

  Future<Map<String, dynamic>> insertBorrowing(int userId, int bookId) async {
    final http.Response response = await http.post(
      Uri.parse(borrowingUrl),
      headers: <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded',
        HttpHeaders.authorizationHeader: token
      },
      body: <String, dynamic> {
        'user_id': userId,
        'book_id': bookId,
      },
    );
    final responseJson = jsonDecode(response.body);
    return {
      'status': responseJson['status'],
      'message': responseJson['message'],
    };
  }

  Future<Map<String, dynamic>> updateBorrowing(int id, int userId, int bookId, DateTime returnDate, bool isReturned, bool isLate) async {
    final response = await http.put(
      Uri.parse('$borrowingUrl/$id'),
      headers: <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded',
        HttpHeaders.authorizationHeader: token
      },
      body: <String, dynamic> {
        'user_id': userId,
        'book_id': bookId,
        'return_date': returnDate,
        'is_returned': isReturned,
        'is_late': isLate,
      },
    );
    final responseJson = jsonDecode(response.body);
    return {
      'status': responseJson['status'],
      'message': responseJson['message'],
    };
  }

  Future<Map<String, dynamic>> deleteBorrowing(int id) async {
    final response = await http.delete(
      Uri.parse('$borrowingUrl/$id'),
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