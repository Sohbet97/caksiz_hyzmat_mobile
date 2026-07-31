import 'package:dio/dio.dart';
import 'package:mobile/features/products/models/product_filter_model.dart';
import 'package:mobile/features/products/models/product_response.dart';

class ProductRepository {
  final Dio dio;

  ProductRepository({required this.dio});

  Future<ProductResponse> getProducts(
    ProductFilterModel filterModel, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.get(
        'products',
        queryParameters: filterModel.toQueryParameters(),
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data as Map<String, dynamic>);
      }
      throw Exception('Failed to load products: ${response.statusCode}');
    } catch (e) {
      throw Exception(e);
    }
  }
}
