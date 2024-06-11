class Review {
  final int id;
  final int userId;
  final int bookId;
  final String description;
  
  const Review({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.description
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id,
      'user_id': int userId,
      'book_id': int bookId,
      'description': String description
      } => Review(id: id, 
      userId: userId, 
      bookId: bookId, 
      description: description),
      _ => throw const FormatException('Failed to load review :(')
    };
  }
}