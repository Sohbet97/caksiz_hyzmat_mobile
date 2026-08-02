import 'dart:ui' show Locale;

import 'package:mobile/core/utils/models/media_model.dart';
import 'package:mobile/features/brands/model/brand_model.dart';
import 'package:mobile/features/products/models/currency_model.dart';
import 'package:mobile/features/products/models/product_detail_model.dart';

double _parseDouble(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0;
}

double? _parseNullableDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}

int? _parseNullableInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}

class ProductModel {
  final int id;
  final String nameTm;
  final String nameRu;
  final String nameEn;
  final String descriptionTm;
  final String descriptionRu;
  final String descriptionEn;
  final String sku;
  final int? mediaId;
  final int? brandId;
  final double costPrice;
  final double salePrice;
  final double? weigthGrams;
  final int countView;
  final int countOrder;
  final double rating;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String searchVector;
  final MediaDetailModel? tubnailModel;
  final BrandModel? brandModel;
  final ProductCurrencyModel? currencyModel;

  ProductModel({
    required this.id,
    required this.nameTm,
    required this.nameRu,
    required this.nameEn,
    required this.descriptionTm,
    required this.descriptionRu,
    required this.descriptionEn,
    required this.sku,
    required this.mediaId,
    required this.brandId,
    required this.costPrice,
    required this.salePrice,
    required this.weigthGrams,
    required this.countView,
    required this.countOrder,
    required this.rating,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.searchVector,
    required this.tubnailModel,
    required this.brandModel,
    required this.currencyModel,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: int.parse(json['id'].toString()),
    nameTm: json['name_tm'] ?? '',
    nameRu: json['name_ru'] ?? '',
    nameEn: json['name_en'] ?? '',
    descriptionTm: json['description_tm'] ?? '',
    descriptionRu: json['description_ru'] ?? '',
    descriptionEn: json['description_en'] ?? '',
    sku: json['sku'] ?? '',
    mediaId: _parseNullableInt(json['thumbnail_media_id']),
    brandId: _parseNullableInt(json['brand_id']),
    costPrice: _parseDouble(json['cost_price']),
    salePrice: _parseDouble(json['sale_price']),
    weigthGrams: _parseNullableDouble(json['weight_grams']),
    countView: json['count_view'] as int? ?? 0,
    countOrder: json['count_order'] as int? ?? 0,
    rating: _parseDouble(json['rating']),
    isActive: json['is_active'] as bool? ?? true,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'].toString())
        : DateTime.now(),
    updatedAt: json['updated_at'] != null
        ? DateTime.parse(json['updated_at'].toString())
        : null,
    searchVector: json['search_vector'] ?? '',
    tubnailModel: json['thumbnail_media'] != null
        ? MediaDetailModel.fromJson(
            json['thumbnail_media'] as Map<String, dynamic>,
          )
        : null,
    brandModel: json['brand'] != null
        ? BrandModel.fromJson(json['brand'] as Map<String, dynamic>)
        : null,
    currencyModel: json['currency'] != null
        ? ProductCurrencyModel.fromJson(
            json['currency'] as Map<String, dynamic>,
          )
        : null,
  );

  factory ProductModel.fromDetail(ProductDetailModel detail) => ProductModel(
    id: detail.id,
    nameTm: detail.nameTm,
    nameRu: detail.nameRu,
    nameEn: detail.nameEn,
    descriptionTm: detail.descriptionTm,
    descriptionRu: detail.descriptionRu,
    descriptionEn: detail.descriptionEn,
    sku: detail.sku,
    mediaId: detail.thumbnailMediaId,
    brandId: detail.brandId,
    costPrice: detail.costPrice,
    salePrice: detail.salePrice,
    weigthGrams: detail.weigthGrams,
    countView: detail.countView,
    countOrder: detail.countOrder,
    rating: detail.rating,
    isActive: detail.isActive,
    createdAt: detail.createdAt,
    updatedAt: detail.updatedAt,
    searchVector: detail.searchVector,
    tubnailModel: detail.thumbnailMedia,
    brandModel: detail.brand,
    currencyModel: detail.currency,
  );
}

extension ProductLocalization on ProductModel {
  String localizedName(Locale locale) {
    return switch (locale.languageCode) {
      'tm' => nameTm,
      'en' => nameEn.isNotEmpty ? nameEn : nameRu,
      _ => nameRu,
    };
  }
}
