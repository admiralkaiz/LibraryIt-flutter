class Book {
  final int id;
  final String isbn;
  final String title;
  final String author;
  final String publisher;
  final int year;
  final String synopsis;

  const Book({
    required this.id,
    required this.isbn,
    required this.title,
    required this.author,
    required this.publisher,
    required this.year,
    required this.synopsis
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json['id'], 
    isbn: json['isbn'], 
    title: json['title'], 
    author: json['author'], 
    publisher: json['publisher'], 
    year: json['year'], 
    synopsis: json['synopsis']);

  Map toJson() {
    return {
      'id': id,
      'isbn': isbn,
      'title': title,
      'author': author,
      'publisher': publisher,
      'year': year,
      'synopsis': synopsis,
    };
  }
}