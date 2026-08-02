import 'package:dio/dio.dart';
import 'package:mobile/core/storage/settings_storage.dart';
import 'package:mobile/features/favorite/model/favorite_filter_model.dart';
import 'package:mobile/features/favorite/model/favorite_model.dart';
import 'package:mobile/features/favorite/model/favorite_response.dart';

class FavoriteRepository {
  final Dio dio;
  final SettingsStorage storage;

  FavoriteRepository({required this.dio, required this.storage});

  Future<FavoriteResponse> loadFavorites({
    FavoriteFilterModel filterModel = const FavoriteFilterModel(),
    CancelToken? cancelToken,
  }) async {
    final userId = await storage.readUserId();
    final response = await dio.get(
      'favorites',
      queryParameters: {...filterModel.toQueryParameters(), 'userId': ?userId},
      cancelToken: cancelToken,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load favorites: ${response.statusCode}');
    }

    return FavoriteResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<FavoriteModel> addFavorite(int productId) async {
    final response = await dio.post(
      'favorites',
      data: {'productId': productId},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add favorite: ${response.statusCode}');
    }

    return FavoriteModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> removeFavorite(int favoriteId) async {
    final response = await dio.delete('favorites/$favoriteId');

    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception('Failed to remove favorite: ${response.statusCode}');
    }
  }
}
