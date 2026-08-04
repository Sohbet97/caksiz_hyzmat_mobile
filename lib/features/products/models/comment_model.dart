class CommentModel {
  final int id;
  final String userName;
  final double rating;
  final String text;
  final DateTime createdAt;

  const CommentModel({
    required this.id,
    required this.userName,
    required this.rating,
    required this.text,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json['id'] as int,
        userName: json['user_name'] as String? ?? '',
        rating: (json['rating'] as num? ?? 0).toDouble(),
        text: json['text'] as String? ?? '',
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : DateTime.now(),
      );
}