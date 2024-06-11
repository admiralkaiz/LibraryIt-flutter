class Post {
  final int id;
  final int userId;
  final String title;
  final String description;
  
  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.description
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id,
      'user_id': int userId,
      'title': String title,
      'description': String description
      } => Post(id: id, 
      userId: userId, 
      title: title, 
      description: description),
      _ => throw const FormatException('Failed to load post :(')
    };
  }
}