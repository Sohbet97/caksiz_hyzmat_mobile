import 'package:dio/dio.dart';
import 'package:mobile/core/storage/settings_storage.dart';

class ViewedProductsRepository {
  final Dio dio;
  final SettingsStorage storage;

  ViewedProductsRepository({required this.dio, required this.storage});

  /// Отсортировано от последнего просмотренного к самому старому.
  Future<List<int>> getViewedProductIds() => storage.readViewedProductIds();
}
