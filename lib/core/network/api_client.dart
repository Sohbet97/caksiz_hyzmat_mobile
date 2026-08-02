import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile/core/network/interceptors/interceptors.dart';
import 'package:mobile/core/storage/settings_storage.dart';

class ApiClient {
  final Dio dio;
  final SettingsStorage settingsStorage;
  static String baseUrl = 'https://caksizhyzmat.com/api/';
  // static String baseUrl = 'http://192.168.1.106:3000/api/';

  Future<bool>? _refreshing;

  ApiClient({required this.settingsStorage})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          // Every status code resolves as a normal response (never throws),
          // so 401 handling has to live in onResponse, not onError.
          validateStatus: (status) => true,
          headers: {
            "Content-Type": "application/json",
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36',
          },
        ),
      ) {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await settingsStorage.readAuthToken();
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
        onResponse: (response, handler) async {
          if (response.statusCode != 401) {
            return handler.next(response);
          }

          final isRefreshCall = response.requestOptions.path.contains(
            'auth/refresh',
          );
          final alreadyRetried =
              response.requestOptions.extra['retried'] == true;

          if (!isRefreshCall && !alreadyRetried) {
            final refreshed = await _refreshSession();
            if (refreshed) {
              response.requestOptions.extra['retried'] = true;
              try {
                final retryResponse = await dio.fetch(response.requestOptions);
                return handler.resolve(retryResponse);
              } catch (_) {
                // fall through to the expired-session handling below
              }
            } else {
              await _clearSession();
            }
          }

          showGlobalMessage('Сессия истекла. Пожалуйста, войдите снова.');
          return handler.next(response);
        },
        onError: (e, handler) {
          if (e.type == DioExceptionType.connectionError) {
            showGlobalMessage('Нет подключения к интернету');
          }

          return handler.next(e);
        },
      ),
    );
  }

  /// Вызывается один раз при старте приложения — если сохранённый access
  /// token уже просрочен (например, приложение было закрыто дольше, чем
  /// живёт токен), рефрешим его до того, как остальные блоки начнут
  /// параллельно стучаться в защищённые эндпоинты.
  Future<void> ensureValidSession() async {
    final token = await settingsStorage.readAuthToken();
    if (token == null || token.isEmpty || !_isTokenExpired(token)) return;
    await _refreshSession();
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;

      var payload = parts[1].replaceAll('-', '+').replaceAll('_', '/');
      payload += '=' * ((4 - payload.length % 4) % 4);
      final json = jsonDecode(utf8.decode(base64Decode(payload)));
      final exp = json['exp'] as int?;
      if (exp == null) return false;

      final expiresAt = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      // Небольшой запас, чтобы не словить 401 сразу после проверки.
      return DateTime.now().isAfter(
        expiresAt.subtract(const Duration(seconds: 10)),
      );
    } catch (_) {
      return false;
    }
  }

  Future<bool> _refreshSession() {
    return _refreshing ??= _doRefresh().whenComplete(() {
      _refreshing = null;
    });
  }

  Future<bool> _doRefresh() async {
    final refreshToken = await settingsStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return false;

    try {
      final response = await dio.post(
        'auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode != 200) return false;

      final body = response.data as Map<String, dynamic>;
      final newAccessToken = body['accessToken'] as String?;
      final newRefreshToken = body['refreshToken'] as String?;
      if (newAccessToken == null || newAccessToken.isEmpty) return false;

      await settingsStorage.writeAuthToken(newAccessToken);
      if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
        await settingsStorage.writeRefreshToken(newRefreshToken);
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _clearSession() async {
    await settingsStorage.writeAuthToken('');
    await settingsStorage.writeRefreshToken('');
    await settingsStorage.saveRegistrationStatus(false);
  }

  // TODO: заменить путь и тело запроса на реальный контракт бэкенда.
  Future<void> registerPushToken(String token) async {
    try {
      await dio.post('/push-tokens', data: {'token': token});
    } catch (e) {
      print(e);
    }
  }
}
