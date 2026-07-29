import 'package:dio/dio.dart';
import 'package:mobile/features/category/models/category_model.dart';

class CategoryRepository {
  final Dio dio;

  CategoryRepository({required this.dio});

  Future<List<CategoryModel>> loadAllCategories() async {
    try {
      final response = await dio.get(
        'categories',
        queryParameters: {'limit': 100, 'page': 1},
      );
      final categories = (response.data['data'] as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList();
      return categories;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CategoryModel>> buildTreeList(
    List<CategoryModel> categories,
  ) async {
    final treeCategories = await CategoryModel.buildTree(categories);
    return treeCategories;
  }
}
