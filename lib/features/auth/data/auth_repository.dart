import 'package:dio/dio.dart';
import 'package:mobile/core/storage/settings_storage.dart';
import 'package:mobile/features/person/models/person_model.dart';

class AuthRepository {
  final Dio dio;
  final SettingsStorage storage;
  AuthRepository({required this.dio, required this.storage});

  Future<Response> loginWithGoogle(String idToken) async {
    final response = await dio.post('auth/google', data: {'idToken': idToken});

    if (response.statusCode != 200 && response.statusCode != 201) {
      print('data: ${response.data}');
      throw Exception('Google auth failed: ${response.statusCode}');
    }

    final token = response.data['accessToken'] as String?;
    if (token != null) {
      await storage.writeAuthToken(token);
      await storage.saveRegistrationStatus(true);
    }

    return response;
  }

  Future<PersonModel> getMe() async {
    final response = await dio.get('users/me');

    if (response.statusCode != 200) {
      throw Exception('Error code: ${response.statusCode}');
    }

    final body = response.data as Map<String, dynamic>;
    final person = PersonModel.fromJson(body['data'] as Map<String, dynamic>);
    await storage.writeUserId(person.id);
    await storage.saveRegistrationStatus(true);
    return person;
  }

  Future<Response> login({
    required String phoneNumber,
    required String password,
  }) async {
    final response = await dio.post(
      'auth/login',
      data: {'phoneNumber': phoneNumber, 'password': password},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Login failed: ${response.statusCode}');
    }

    return response;
  }

  Future<Response> refresh() => dio.post('auth/refresh');

  Future<Response> logout() => dio.post('auth/logout');
}
