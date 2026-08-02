class FavoriteFilterModel {
  final int page;
  final int limit;

  /// Большой лимит по умолчанию — чтобы получать все избранные товары
  /// пользователя за один запрос.
  const FavoriteFilterModel({this.page = 1, this.limit = 10000});

  FavoriteFilterModel copyWith({int? page, int? limit}) {
    return FavoriteFilterModel(
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  Map<String, dynamic> toQueryParameters() => {'page': page, 'limit': limit};
}
