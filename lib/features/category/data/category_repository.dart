import 'package:dio/dio.dart';
import 'package:mobile/features/category/models/category_model.dart';

class CategoryRepository {
  final Dio dio;

  CategoryRepository({required this.dio});

  List<CategoryModel>? _cats;

  Future<List<CategoryModel>> loadAllCategories() async {
    if (_cats != null) return _cats!;
    try {
      final response = await dio.get('categories/tree');
      final categories = (response.data['data'] as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList();
      _cats = categories;
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
