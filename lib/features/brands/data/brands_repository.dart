import 'package:dio/dio.dart' show CancelToken, Dio;
import 'package:mobile/features/brands/model/brand_filter_model.dart';
import 'package:mobile/features/brands/model/brand_response.dart';

class BrandsRepository {
  final Dio dio;

  BrandsRepository({required this.dio});

  Future<BrandResponse> loadBrands(
    BrandFilterModel filterModel, {
    CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      'brands',
      queryParameters: filterModel.toQueryParameters(),
      cancelToken: cancelToken,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load brands: ${response.statusCode}');
    }

    return BrandResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
