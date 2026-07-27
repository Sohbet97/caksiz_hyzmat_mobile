import 'package:dio/dio.dart';
import 'package:mobile/features/schools/data/models/school_model.dart';

class SchoolsRepository {
  final Dio dio;

  SchoolsRepository({required this.dio});

  Future<List<SchoolModel>> loadSchools() async {
    return [];
  }
}
