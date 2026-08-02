import 'package:equatable/equatable.dart';

final class FavoriteModel extends Equatable {
  final int id;
  final int userId;
  final int productId;
  final DateTime createdAt;

  const FavoriteModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.createdAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    id: json['id'] as int,
    userId: json['user_id'] as int,
    productId: json['product_id'] as int,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'].toString())
        : DateTime.now(),
  );

  @override
  List<Object?> get props => [id, userId, productId, createdAt];
}
