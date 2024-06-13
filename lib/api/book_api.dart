import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:libraryit/models/book.dart';
import 'package:libraryit/models/review.dart';
import 'url.dart';

class BookApi {
  final String bookUrl = '$apiUrl/books';
  final String token;

  const BookApi({
    required this.token,
  });

  factory BookApi.newFromToken(String token) => BookApi(token: token);

  Future<Map<String, dynamic>> getAllBooks() async {
    final response = await http.get(
      Uri.parse(bookUrl),
      headers: {
        HttpHeaders.authorizationHeader: token
      }
    );
    final isOk = response.statusCode == 200;
    return {
      'status': isOk,
      'data': isOk ? (jsonDecode(response.body) as List).map((book) => Book.fromJson(book)).toList() : {},
      'message': isOk ? 'Successfully loaded books!' : 'Failed to load books!',
    };
  }

  Future<Map<String, dynamic>> getBookById(int id) async {
    final response = await http.get(
      Uri.parse('$bookUrl/$id'),
      headers: {
        HttpHeaders.authorizationHeader: token
      }
    );
    final jsonResponse = jsonDecode(response.body);

    Map<String, dynamic> result = <String, dynamic>{};
    result['status'] = jsonResponse['status'];
    result['message'] = jsonResponse['message'];
    result['data'] = response.statusCode == 200 ? 
      {'book': Book.fromJson(jsonResponse['data']['book'] as Map<String, dynamic>),
      'reviews': (jsonResponse['data']['reviews'] as List).map((review) => Review.fromJson(review)).toList()} : 
      {};
    return result;
  }

  Future<Map<String, dynamic>> insertBook(String isbn, String title, String author, String publisher, int year, String synopsis) async {
    final http.Response response = await http.post(
      Uri.parse(bookUrl),
      headers: <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded',
        HttpHeaders.authorizationHeader: token
      },
      body: <String, dynamic> {
        'isbn': isbn,
        'title': title,
        'author': author,
        'publisher': publisher,
        'year': year,
        'synposis': synopsis,
      },
    );
    final responseJson = jsonDecode(response.body);
    return {
      'status': responseJson['status'],
      'message': responseJson['message'],
    };
  }

  Future<Map<String, dynamic>> updateBook(int id, String isbn, String title, String author, String publisher, int year, String synopsis) async {
    final response = await http.put(
      Uri.parse('$bookUrl/$id'),
      headers: <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded',
        HttpHeaders.authorizationHeader: token
      },
      body: <String, dynamic> {
        'isbn': isbn,
        'title': title,
        'author': author,
        'publisher': publisher,
        'year': year,
        'synposis': synopsis,
      },
    );
    final responseJson = jsonDecode(response.body);
    return {
      'status': responseJson['status'],
      'message': responseJson['message'],
    };
  }

  Future<Map<String, dynamic>> deleteBook(int id) async {
    final response = await http.delete(
      Uri.parse('$bookUrl/$id'),
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