import 'package:equatable/equatable.dart';

class ProductFilterModel extends Equatable {
  final int page;
  final int limit;
  final String? search;
  final int? brandId;
  final int? categoryId;

  const ProductFilterModel({
    this.page = 1,
    this.limit = 20,
    this.search,
    this.brandId,
    this.categoryId,
  });

  ProductFilterModel copyWith({
    int? page,
    int? limit,
    String? search,
    int? brandId,
    int? categoryId,
  }) => ProductFilterModel(
    page: page ?? this.page,
    limit: limit ?? this.limit,
    search: search ?? this.search,
    brandId: brandId ?? this.brandId,
    categoryId: categoryId ?? this.categoryId,
  );

  ProductFilterModel resetPage() => copyWith(page: 1);

  Map<String, dynamic> toQueryParameters() => {
    'page': page,
    'limit': limit,
    if (search != null && search!.isNotEmpty) 'search': search,
    if (brandId != null) 'brand_id': brandId,
    if (categoryId != null) 'category_id': categoryId,
  };

  @override
  List<Object?> get props => [page, limit, search, brandId, categoryId];
}
