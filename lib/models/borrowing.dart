class Borrowing {
  final int id;
  final int userId;
  final int bookId;
  final DateTime borrowDate;
  final DateTime returnDate;
  final bool isReturned;
  final bool isLate;
  
  const Borrowing({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.borrowDate,
    required this.returnDate,
    required this.isReturned,
    required this.isLate
  });

  factory Borrowing.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id,
      'user_id': int userId,
      'book_id': int bookId,
      'borrow_date': DateTime borrowDate,
      'return_date': DateTime returnDate,
      'is_returned': bool isReturned,
      'is_late': bool isLate
      } => Borrowing(id: id, 
      userId: userId, 
      bookId: bookId, 
      borrowDate: borrowDate, 
      returnDate: returnDate, 
      isReturned: isReturned, 
      isLate: isLate),
      _ => throw const FormatException('Failed to load borrowings :(')
    };
  }
}