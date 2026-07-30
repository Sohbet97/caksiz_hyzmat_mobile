import 'package:equatable/equatable.dart';
import 'package:mobile/core/utils/models/media_model.dart';

class CategoryModel extends Equatable {
  final int id;
  final String nameTm;
  final String? nameRu;
  final String? nameEn;
  final String slug;
  final int? mediaId;
  final int? parentId;
  final int sortOrder;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final MediaDetailModel? media;
  final List<CategoryModel> children;

  const CategoryModel({
    required this.id,
    required this.nameTm,
    this.nameRu,
    this.nameEn,
    required this.slug,
    this.mediaId,
    this.parentId,
    this.sortOrder = 0,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    this.media,
    required this.children,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: _parseInt(json['id'])!,
      nameTm: json['name_tm'] as String? ?? '',
      nameRu: json['name_ru'] as String?,
      nameEn: json['name_en'] as String?,
      slug: json['slug'] as String? ?? '',
      mediaId: _parseInt(json['media_id']),
      parentId: _parseInt(json['parent_id']),
      sortOrder: json['sort_order'] as int? ?? 0,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      media: json['media'] != null
          ? MediaDetailModel.fromJson(json['media'] as Map<String, dynamic>)
          : null,
      children: (json['children'] as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_tm': nameTm,
      'name_ru': nameRu,
      'name_en': nameEn,
      'slug': slug,
      'media_id': mediaId,
      'parent_id': parentId,
      'sort_order': sortOrder,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'media': media?.toJson(),
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

  CategoryModel copyWith({
    int? id,
    String? nameTm,
    String? nameRu,
    String? nameEn,
    String? slug,
    int? mediaId,
    int? parentId,
    int? sortOrder,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    MediaDetailModel? media,
    List<CategoryModel>? children,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      nameTm: nameTm ?? this.nameTm,
      nameRu: nameRu ?? this.nameRu,
      nameEn: nameEn ?? this.nameEn,
      slug: slug ?? this.slug,
      mediaId: mediaId ?? this.mediaId,
      parentId: parentId ?? this.parentId,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      media: media ?? this.media,
      children: children ?? this.children,
    );
  }

  static Future<List<CategoryModel>> buildTree(
    List<CategoryModel> categories,
  ) async {
    final childrenByParentId = <int, List<CategoryModel>>{};
    for (final category in categories) {
      final parentId = category.parentId;
      if (parentId != null) {
        childrenByParentId.putIfAbsent(parentId, () => []).add(category);
      }
    }

    CategoryModel attachChildren(CategoryModel category) {
      final childCategories = childrenByParentId[category.id];
      if (childCategories == null || childCategories.isEmpty) {
        return category;
      }
      return category.copyWith(
        children: childCategories.map(attachChildren).toList(),
      );
    }

    return categories
        .where((category) => category.parentId == null)
        .map(attachChildren)
        .toList();
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  @override
  List<Object?> get props => [
    id,
    nameTm,
    nameRu,
    nameEn,
    slug,
    mediaId,
    parentId,
    sortOrder,
    isActive,
    createdAt,
    updatedAt,
    media,
    children,
  ];
}
