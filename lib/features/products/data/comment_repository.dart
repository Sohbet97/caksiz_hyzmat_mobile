import 'package:dio/dio.dart';

import '../models/comment_model.dart';

class CommentRepository {
  final Dio dio;

  CommentRepository({required this.dio});

  Future<List<CommentModel>> getComments(int productId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      CommentModel(
        id: 1,
        userName: 'fa***a0',
        rating: 5,
        text: 'Gaty gowy haryt, hiç hili näsazlyk ýok',
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
      CommentModel(
        id: 2,
        userName: 'me***v3',
        rating: 4.5,
        text: 'Dastawka gaty çalt, haryt oňat',
        createdAt: DateTime.now().subtract(const Duration(days: 35)),
      ),
      CommentModel(
        id: 3,
        userName: 'gu***y7',
        rating: 5,
        text: 'Maslahat berýärin, hiç hili şikayatym ýok',
        createdAt: DateTime.now().subtract(const Duration(days: 50)),
      ),
    ];
  }
}