class BannerFilterModel {
  final int page;
  final int limit;
  final String? position;

  BannerFilterModel({this.page = 1, this.limit = 20, this.position});

  BannerFilterModel copyWith({int? page, int? limit, String? position}) {
    return BannerFilterModel(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toQueryParameters() => {
    'page': page,
    'limit': limit,
    if (position != null && position!.isNotEmpty) 'position': position,
  };
}
