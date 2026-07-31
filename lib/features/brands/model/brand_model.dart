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
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    id: json['id'] as int,
    name: json['name'] ?? '',
    slug: json['slug'] ?? '',
    mediaId: json['media_id'] as int?,
    isActive: json['is_active'] as bool,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'].toString())
        : DateTime.now(),
    sortOrder: json['sort_order'] as int,
    updatedAt: json['updated_at'] != null
        ? DateTime.parse(json['updated_at'].toString())
        : DateTime.now(),
    description: json['description'] ?? '',
  );
}
