class BrandFilterModel {
  final int page;
  final int limit;
  final String? search;

  BrandFilterModel({this.page = 1, this.limit = 20, this.search});

  BrandFilterModel copyWith({int? page, int? limit, String? search}) {
    return BrandFilterModel(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      search: search ?? this.search,
    );
  }

  BrandFilterModel resetPage() => copyWith(page: 1);

  Map<String, dynamic> toQueryParameters() => {
    'page': page,
    'limit': limit,
    if (search != null && search!.isNotEmpty) 'search': search,
  };
}
