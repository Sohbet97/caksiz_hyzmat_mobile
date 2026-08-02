import 'package:mobile/features/products/models/product_model.dart';

class ProductResponse {
  final List<ProductModel> products;
  final ResponseMeta meta;

  ProductResponse({required this.products, required this.meta});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        products: (json['data'] as List<dynamic>? ?? [])
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        meta: ResponseMeta.fromJson(json['meta'] as Map<String, dynamic>),
      );
}

class ResponseMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPage;

  ResponseMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPage,
  });

  factory ResponseMeta.fromJson(Map<String, dynamic> json) => ResponseMeta(
    total: json['total'] as int? ?? 0,
    page: json['page'] as int? ?? 1,
    limit: json['limit'] as int? ?? 0,
    totalPage: json['totalPages'] as int? ?? 0,
  );

  bool get hasNextPage => page < totalPage;
}
