import 'package:dio/dio.dart';
import 'package:mobile/features/schools/data/models/pagination.dart';
import 'package:mobile/features/schools/data/models/school_detail_model.dart';
import 'package:mobile/features/schools/data/models/school_model.dart';

class SchoolsRepository {
  final Dio dio;

  SchoolsRepository({required this.dio});

  Future<PaginatedResponse<SchoolModel>> loadSchools({
    int page = 1,
    int limit = 20,
    String? search,
    int? cityId,
  }) async {
    final response = await dio.get(
      'schools',
      queryParameters: {
        'page': page,
        'limit': limit,
        if (search != null && search.isNotEmpty) 'search': search,
        'cityId': ?cityId,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load schools: ${response.statusCode}');
    }

    return PaginatedResponse.fromJson(
      response.data as Map<String, dynamic>,
      SchoolModel.fromJson,
    );
  }

  Future<SchoolDetailModel> loadSchoolDetail(int schoolId) async {
    try {
      final response = await dio.get('schools/$schoolId');
      if (response.statusCode != 200) {
        throw Exception('Okuw maglumatlary almakda näsazlyk');
      }
      final data = SchoolDetailModel.fromJson(response.data['data']);
      return data;
    } catch (e) {
      throw Exception('Okuw maglumatlary almakda näsazlyk');
    }
  }
}
