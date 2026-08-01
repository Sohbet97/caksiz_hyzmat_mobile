import 'package:dio/dio.dart';
import 'package:mobile/core/storage/settings_storage.dart';

class ReviewRepository {
  final Dio dio;
  final SettingsStorage storage;

  ReviewRepository({required this.dio, required this.storage});
}
