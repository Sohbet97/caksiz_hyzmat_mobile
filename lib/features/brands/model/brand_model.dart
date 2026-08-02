import 'package:mobile/core/utils/models/media_model.dart';

int _parseId(dynamic value) =>
    value is String ? int.parse(value) : value as int;

class BrandModel {
  final int id;
  final String name;
  final String slug;
  final int? mediaId;
  final bool isActive;
  final DateTime createdAt;
  final int sortOrder;
  final DateTime updatedAt;
  final String description;
  final MediaDetailModel? media;
  BrandModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.mediaId,
    required this.isActive,
    required this.createdAt,
    required this.sortOrder,
    required this.updatedAt,
    required this.description,
    required this.media,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    id: _parseId(json['id']),
    name: json['name'] ?? '',
    slug: json['slug'] ?? '',
    mediaId: json['media_id'] != null ? _parseId(json['media_id']) : null,
    isActive: json['is_active'] as bool? ?? true,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'].toString())
        : DateTime.now(),
    sortOrder: json['sort_order'] as int? ?? 0,
    updatedAt: json['updated_at'] != null
        ? DateTime.parse(json['updated_at'].toString())
        : DateTime.now(),
    description: json['description'] ?? '',
    media: json['media'] != null
        ? MediaDetailModel.fromJson(json['media'])
        : null,
  );
}
