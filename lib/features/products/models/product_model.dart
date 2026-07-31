import 'package:equatable/equatable.dart';
import 'package:mobile/core/utils/models/media_model.dart';

class ProductModel extends Equatable {
  final int id;
  final String nameTm;
  final String? nameRu;
  final String? nameEn;
  final String slug;
  final String? description;
  final double price;
  final double? oldPrice;
  final String? sku;
  final int stock;
  final int? categoryId;
  final int? brandId;
  final bool isActive;
  final MediaDetailModel? media;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductModel({
    required this.id,
    required this.nameTm,
    this.nameRu,
    this.nameEn,
    required this.slug,
    this.description,
    required this.price,
    this.oldPrice,
    this.sku,
    this.stock = 0,
    this.categoryId,
    this.brandId,
    this.isActive = true,
    this.media,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: _parseInt(json['id'])!,
      nameTm: json['name_tm'] as String? ?? '',
      nameRu: json['name_ru'] as String?,
      nameEn: json['name_en'] as String?,
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String?,
      price: _parseDouble(json['price']) ?? 0,
      oldPrice: _parseDouble(json['old_price']),
      sku: json['sku'] as String?,
      stock: _parseInt(json['stock']) ?? 0,
      categoryId: _parseInt(json['category_id']),
      brandId: _parseInt(json['brand_id']),
      isActive: json['is_active'] as bool? ?? true,
      media: json['media'] != null
          ? MediaDetailModel.fromJson(json['media'] as Map<String, dynamic>)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_tm': nameTm,
      'name_ru': nameRu,
      'name_en': nameEn,
      'slug': slug,
      'description': description,
      'price': price,
      'old_price': oldPrice,
      'sku': sku,
      'stock': stock,
      'category_id': categoryId,
      'brand_id': brandId,
      'is_active': isActive,
      'media': media?.toJson(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  ProductModel copyWith({
    int? id,
    String? nameTm,
    String? nameRu,
    String? nameEn,
    String? slug,
    String? description,
    double? price,
    double? oldPrice,
    String? sku,
    int? stock,
    int? categoryId,
    int? brandId,
    bool? isActive,
    MediaDetailModel? media,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      nameTm: nameTm ?? this.nameTm,
      nameRu: nameRu ?? this.nameRu,
      nameEn: nameEn ?? this.nameEn,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      sku: sku ?? this.sku,
      stock: stock ?? this.stock,
      categoryId: categoryId ?? this.categoryId,
      brandId: brandId ?? this.brandId,
      isActive: isActive ?? this.isActive,
      media: media ?? this.media,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  @override
  List<Object?> get props => [
    id,
    nameTm,
    nameRu,
    nameEn,
    slug,
    description,
    price,
    oldPrice,
    sku,
    stock,
    categoryId,
    brandId,
    isActive,
    media,
    createdAt,
    updatedAt,
  ];
}
