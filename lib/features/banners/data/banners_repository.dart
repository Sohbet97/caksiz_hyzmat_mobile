import 'package:dio/dio.dart' show CancelToken, Dio;
import 'package:mobile/features/banners/model/banner_filter_model.dart';
import 'package:mobile/features/banners/model/banner_response.dart';

class BannersRepository {
  final Dio dio;

  BannersRepository({required this.dio});

  Future<BannerResponse> loadBanners(
    BannerFilterModel filterModel, {
    CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      'banners',
      queryParameters: filterModel.toQueryParameters(),
      cancelToken: cancelToken,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load banners: ${response.statusCode}');
    }

    return BannerResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
