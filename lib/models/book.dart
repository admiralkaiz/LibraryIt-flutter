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

  factory Book.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 
      'isbn': String isbn, 
      'title': String title, 
      'author': String author,
      'publisher': String publisher,
      'year': int year,
      'synopsis': String synopsis
      } => Book(id: id, 
      isbn: isbn, 
      title: title, 
      author: author, 
      publisher: publisher, 
      year: year, 
      synopsis: synopsis),
      
      _ => throw const FormatException("Failed to load a book :("),
    };
  }
}