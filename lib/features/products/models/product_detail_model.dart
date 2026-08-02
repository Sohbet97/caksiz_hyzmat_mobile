import 'dart:ui' show Color, Locale;

import 'package:equatable/equatable.dart';
import 'package:mobile/core/utils/models/media_model.dart';
import 'package:mobile/features/brands/model/brand_model.dart';
import 'package:mobile/features/products/models/currency_model.dart';

int _parseInt(dynamic value) =>
    value is String ? int.parse(value) : value as int;

int? _parseNullableInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}

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

/// Плоский снимок категории, как он приходит внутри товара — без children,
/// в отличие от [mobile.features.category.models.category_model.CategoryModel].
final class ProductCategorySummaryModel extends Equatable {
  final int id;
  final String slug;
  final String nameTm;
  final String nameRu;
  final String nameEn;
  final int? mediaId;
  final int? parentId;
  final bool isActive;
  final int sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductCategorySummaryModel({
    required this.id,
    required this.slug,
    required this.nameTm,
    required this.nameRu,
    required this.nameEn,
    this.mediaId,
    this.parentId,
    required this.isActive,
    this.sortOrder = 0,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductCategorySummaryModel.fromJson(Map<String, dynamic> json) =>
      ProductCategorySummaryModel(
        id: _parseInt(json['id']),
        slug: json['slug'] as String? ?? '',
        nameTm: json['name_tm'] as String? ?? '',
        nameRu: json['name_ru'] as String? ?? '',
        nameEn: json['name_en'] as String? ?? '',
        mediaId: _parseNullableInt(json['media_id']),
        parentId: _parseNullableInt(json['parent_id']),
        isActive: json['is_active'] as bool? ?? true,
        sortOrder: json['sort_order'] as int? ?? 0,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'].toString())
            : null,
      );

  @override
  List<Object?> get props => [
    id,
    slug,
    nameTm,
    nameRu,
    nameEn,
    mediaId,
    parentId,
    isActive,
    sortOrder,
    createdAt,
    updatedAt,
  ];
}

extension ProductCategorySummaryLocalization on ProductCategorySummaryModel {
  String localizedName(Locale locale) {
    return switch (locale.languageCode) {
      'tm' => nameTm,
      'en' => nameEn.isNotEmpty ? nameEn : nameRu,
      _ => nameRu,
    };
  }
}

final class ProductCategoryLinkModel extends Equatable {
  final int id;
  final int productId;
  final int categoryId;
  final DateTime? createdAt;
  final ProductCategorySummaryModel? category;

  const ProductCategoryLinkModel({
    required this.id,
    required this.productId,
    required this.categoryId,
    this.createdAt,
    this.category,
  });

  factory ProductCategoryLinkModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryLinkModel(
        id: _parseInt(json['id']),
        productId: _parseInt(json['product_id']),
        categoryId: _parseInt(json['category_id']),
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : null,
        category: json['category'] != null
            ? ProductCategorySummaryModel.fromJson(
                json['category'] as Map<String, dynamic>,
              )
            : null,
      );

  @override
  List<Object?> get props => [id, productId, categoryId, createdAt, category];
}

final class ProductGalleryItemModel extends Equatable {
  final int id;
  final int productId;
  final int mediaId;
  final int sortOrder;
  final DateTime? createdAt;
  final MediaDetailModel? media;

  const ProductGalleryItemModel({
    required this.id,
    required this.productId,
    required this.mediaId,
    this.sortOrder = 0,
    this.createdAt,
    this.media,
  });

  factory ProductGalleryItemModel.fromJson(Map<String, dynamic> json) =>
      ProductGalleryItemModel(
        id: _parseInt(json['id']),
        productId: _parseInt(json['product_id']),
        mediaId: _parseInt(json['media_id']),
        sortOrder: json['sort_order'] as int? ?? 0,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : null,
        media: json['media'] != null
            ? MediaDetailModel.fromJson(json['media'] as Map<String, dynamic>)
            : null,
      );

  @override
  List<Object?> get props => [
    id,
    productId,
    mediaId,
    sortOrder,
    createdAt,
    media,
  ];
}

final class ProductSizeModel extends Equatable {
  final int id;
  final String value;
  final bool isActive;
  final int sortOrder;
  final DateTime? createdAt;

  const ProductSizeModel({
    required this.id,
    required this.value,
    required this.isActive,
    this.sortOrder = 0,
    this.createdAt,
  });

  factory ProductSizeModel.fromJson(Map<String, dynamic> json) =>
      ProductSizeModel(
        id: _parseInt(json['id']),
        value: json['value'] as String? ?? '',
        isActive: json['is_active'] as bool? ?? true,
        sortOrder: json['sort_order'] as int? ?? 0,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : null,
      );

  @override
  List<Object?> get props => [id, value, isActive, sortOrder, createdAt];
}

final class ProductColorModel extends Equatable {
  final int id;
  final String nameTm;
  final String nameRu;
  final String nameEn;
  final bool isActive;
  final int sortOrder;
  final DateTime? createdAt;
  final String colorValue;

  const ProductColorModel({
    required this.id,
    required this.nameTm,
    required this.nameRu,
    required this.nameEn,
    required this.isActive,
    this.sortOrder = 0,
    this.createdAt,
    required this.colorValue,
  });

  factory ProductColorModel.fromJson(Map<String, dynamic> json) =>
      ProductColorModel(
        id: _parseInt(json['id']),
        nameTm: json['name_tm'] as String? ?? '',
        nameRu: json['name_ru'] as String? ?? '',
        nameEn: json['name_en'] as String? ?? '',
        isActive: json['is_active'] as bool? ?? true,
        sortOrder: json['sort_order'] as int? ?? 0,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : null,
        colorValue: json['color_value'] as String? ?? '#000000',
      );

  /// [colorValue] распарсенный в [Color], например `#ffffff` -> белый.
  Color get swatch {
    final hex = colorValue.replaceFirst('#', '').padLeft(6, '0');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  List<Object?> get props => [
    id,
    nameTm,
    nameRu,
    nameEn,
    isActive,
    sortOrder,
    createdAt,
    colorValue,
  ];
}

extension ProductColorLocalization on ProductColorModel {
  String localizedName(Locale locale) {
    return switch (locale.languageCode) {
      'tm' => nameTm,
      'en' => nameEn.isNotEmpty ? nameEn : nameRu,
      _ => nameRu,
    };
  }
}

final class ProductBulkPriceModel extends Equatable {
  final int id;
  final int productId;
  final int? variationId;
  final int minQuantity;
  final double price;
  final DateTime? createdAt;

  const ProductBulkPriceModel({
    required this.id,
    required this.productId,
    this.variationId,
    required this.minQuantity,
    required this.price,
    this.createdAt,
  });

  factory ProductBulkPriceModel.fromJson(Map<String, dynamic> json) =>
      ProductBulkPriceModel(
        id: _parseInt(json['id']),
        productId: _parseInt(json['product_id']),
        variationId: _parseNullableInt(json['variation_id']),
        minQuantity: json['min_quantity'] as int? ?? 0,
        price: _parseDouble(json['price']),
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : null,
      );

  @override
  List<Object?> get props => [
    id,
    productId,
    variationId,
    minQuantity,
    price,
    createdAt,
  ];
}

final class ProductVariationModel extends Equatable {
  final int id;
  final int productId;
  final int? sizeId;
  final int? colorId;
  final int? mediaId;
  final double price;
  final int? currencyId;
  final int stock;
  final String? sku;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ProductSizeModel? size;
  final ProductColorModel? color;
  final MediaDetailModel? media;
  final ProductCurrencyModel? currency;
  final List<ProductBulkPriceModel> bulkPrices;

  const ProductVariationModel({
    required this.id,
    required this.productId,
    this.sizeId,
    this.colorId,
    this.mediaId,
    required this.price,
    this.currencyId,
    this.stock = 0,
    this.sku,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    this.size,
    this.color,
    this.media,
    this.currency,
    this.bulkPrices = const [],
  });

  factory ProductVariationModel.fromJson(Map<String, dynamic> json) =>
      ProductVariationModel(
        id: _parseInt(json['id']),
        productId: _parseInt(json['product_id']),
        sizeId: _parseNullableInt(json['size_id']),
        colorId: _parseNullableInt(json['color_id']),
        mediaId: _parseNullableInt(json['media_id']),
        price: _parseDouble(json['price']),
        currencyId: _parseNullableInt(json['currency_id']),
        stock: json['stock'] as int? ?? 0,
        sku: json['sku'] as String?,
        isActive: json['is_active'] as bool? ?? true,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'].toString())
            : null,
        size: json['size'] != null
            ? ProductSizeModel.fromJson(json['size'] as Map<String, dynamic>)
            : null,
        color: json['color'] != null
            ? ProductColorModel.fromJson(json['color'] as Map<String, dynamic>)
            : null,
        media: json['media'] != null
            ? MediaDetailModel.fromJson(json['media'] as Map<String, dynamic>)
            : null,
        currency: json['currency'] != null
            ? ProductCurrencyModel.fromJson(
                json['currency'] as Map<String, dynamic>,
              )
            : null,
        bulkPrices: (json['bulk_prices'] as List<dynamic>? ?? [])
            .map(
              (e) => ProductBulkPriceModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  @override
  List<Object?> get props => [
    id,
    productId,
    sizeId,
    colorId,
    mediaId,
    price,
    currencyId,
    stock,
    sku,
    isActive,
    createdAt,
    updatedAt,
    size,
    color,
    media,
    currency,
    bulkPrices,
  ];
}

final class ProductDetailModel extends Equatable {
  final int id;
  final String nameTm;
  final String nameRu;
  final String nameEn;
  final String slug;
  final String descriptionTm;
  final String descriptionRu;
  final String descriptionEn;
  final String sku;
  final int? thumbnailMediaId;
  final int? brandId;
  final double costPrice;
  final double salePrice;
  final int? currencyId;
  final String? countryCode;
  final double? weigthGrams;
  final int countView;
  final int countOrder;
  final double rating;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String searchVector;
  final MediaDetailModel? thumbnailMedia;
  final BrandModel? brand;
  final ProductCurrencyModel? currency;
  final List<ProductGalleryItemModel> gallery;
  final List<ProductCategoryLinkModel> categories;
  final List<ProductVariationModel> variations;
  final List<ProductBulkPriceModel> bulkPrices;

  const ProductDetailModel({
    required this.id,
    required this.nameTm,
    required this.nameRu,
    required this.nameEn,
    required this.slug,
    required this.descriptionTm,
    required this.descriptionRu,
    required this.descriptionEn,
    required this.sku,
    this.thumbnailMediaId,
    this.brandId,
    required this.costPrice,
    required this.salePrice,
    this.currencyId,
    this.countryCode,
    this.weigthGrams,
    this.countView = 0,
    this.countOrder = 0,
    this.rating = 0,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    this.searchVector = '',
    this.thumbnailMedia,
    this.brand,
    this.currency,
    this.gallery = const [],
    this.categories = const [],
    this.variations = const [],
    this.bulkPrices = const [],
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        id: _parseInt(json['id']),
        nameTm: json['name_tm'] as String? ?? '',
        nameRu: json['name_ru'] as String? ?? '',
        nameEn: json['name_en'] as String? ?? '',
        slug: json['slug'] as String? ?? '',
        descriptionTm: json['description_tm'] as String? ?? '',
        descriptionRu: json['description_ru'] as String? ?? '',
        descriptionEn: json['description_en'] as String? ?? '',
        sku: json['sku'] as String? ?? '',
        thumbnailMediaId: _parseNullableInt(json['thumbnail_media_id']),
        brandId: _parseNullableInt(json['brand_id']),
        costPrice: _parseDouble(json['cost_price']),
        salePrice: _parseDouble(json['sale_price']),
        currencyId: _parseNullableInt(json['currency_id']),
        countryCode: json['country_code'] as String?,
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
        searchVector: json['search_vector'] as String? ?? '',
        thumbnailMedia: json['thumbnail_media'] != null
            ? MediaDetailModel.fromJson(
                json['thumbnail_media'] as Map<String, dynamic>,
              )
            : null,
        brand: json['brand'] != null
            ? BrandModel.fromJson(json['brand'] as Map<String, dynamic>)
            : null,
        currency: json['currency'] != null
            ? ProductCurrencyModel.fromJson(
                json['currency'] as Map<String, dynamic>,
              )
            : null,
        gallery: (json['gallery'] as List<dynamic>? ?? [])
            .map(
              (e) => ProductGalleryItemModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        categories: (json['categories'] as List<dynamic>? ?? [])
            .map(
              (e) => ProductCategoryLinkModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        variations: (json['variations'] as List<dynamic>? ?? [])
            .map(
              (e) => ProductVariationModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        bulkPrices: (json['bulk_prices'] as List<dynamic>? ?? [])
            .map(
              (e) => ProductBulkPriceModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  @override
  List<Object?> get props => [
    id,
    nameTm,
    nameRu,
    nameEn,
    slug,
    descriptionTm,
    descriptionRu,
    descriptionEn,
    sku,
    thumbnailMediaId,
    brandId,
    costPrice,
    salePrice,
    currencyId,
    countryCode,
    weigthGrams,
    countView,
    countOrder,
    rating,
    isActive,
    createdAt,
    updatedAt,
    searchVector,
    thumbnailMedia,
    brand,
    currency,
    gallery,
    categories,
    variations,
    bulkPrices,
  ];
}

extension ProductDetailLocalization on ProductDetailModel {
  String localizedName(Locale locale) {
    return switch (locale.languageCode) {
      'tm' => nameTm,
      'en' => nameEn.isNotEmpty ? nameEn : nameRu,
      _ => nameRu,
    };
  }

  String localizedDescription(Locale locale) {
    return switch (locale.languageCode) {
      'tm' => descriptionTm,
      'en' => descriptionEn.isNotEmpty ? descriptionEn : descriptionRu,
      _ => descriptionRu,
    };
  }
}
