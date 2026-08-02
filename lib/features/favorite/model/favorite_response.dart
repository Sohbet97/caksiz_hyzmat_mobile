import 'package:mobile/features/favorite/model/favorite_model.dart';

class FavoriteResponse {
  final List<FavoriteModel> favorites;
  final FavoriteResponseMeta meta;

  FavoriteResponse({required this.favorites, required this.meta});

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) =>
      FavoriteResponse(
        favorites: (json['data'] as List<dynamic>? ?? [])
            .map((e) => FavoriteModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        meta: FavoriteResponseMeta.fromJson(
          json['meta'] as Map<String, dynamic>,
        ),
      );
}

class FavoriteResponseMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  FavoriteResponseMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory FavoriteResponseMeta.fromJson(Map<String, dynamic> json) =>
      FavoriteResponseMeta(
        total: json['total'] as int? ?? 0,
        page: json['page'] as int? ?? 1,
        limit: json['limit'] as int? ?? 0,
        totalPages: json['totalPages'] as int? ?? 0,
      );
}
