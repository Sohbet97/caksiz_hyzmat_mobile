import 'package:mobile/features/brands/model/brand_model.dart';

class BrandResponse {
  final List<BrandModel> brands;
  final BrandResponseMeta meta;

  BrandResponse({required this.brands, required this.meta});

  factory BrandResponse.fromJson(Map<String, dynamic> json) => BrandResponse(
    brands: (json['data'] as List<dynamic>? ?? [])
        .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    meta: BrandResponseMeta.fromJson(json['meta'] as Map<String, dynamic>),
  );
}

class BrandResponseMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  BrandResponseMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory BrandResponseMeta.fromJson(Map<String, dynamic> json) =>
      BrandResponseMeta(
        total: json['total'] as int? ?? 0,
        page: json['page'] as int? ?? 1,
        limit: json['limit'] as int? ?? 0,
        totalPages: json['totalPages'] as int? ?? 0,
      );

  bool get hasNextPage => page < totalPages;
}
