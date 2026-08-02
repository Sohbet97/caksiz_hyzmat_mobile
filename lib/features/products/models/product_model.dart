import 'package:mobile/core/utils/models/media_model.dart';
import 'package:mobile/features/brands/model/brand_model.dart';
import 'package:mobile/features/products/models/currency_model.dart';

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
  final ProductCurrencyModel currencyModel;

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
    id: json['id'] as int,
    nameTm: json['name_tm'] ?? '',
    nameRu: json['name_ru'] ?? '',
    nameEn: json['name_en'] ?? '',
    descriptionTm: json['description_tm'] ?? '',
    descriptionRu: json['description_ru'] ?? '',
    descriptionEn: json['description_en'] ?? '',
    sku: json['sku'] ?? '',
    mediaId: json['media_id'] as int?,
    brandId: json['brand_id'] as int?,
    costPrice: (json['cost_price'] as num? ?? 0).toDouble(),
    salePrice: (json['sale_price'] as num? ?? 0).toDouble(),
    weigthGrams: (json['weigth_grams'] as num?)?.toDouble(),
    countView: json['count_view'] as int? ?? 0,
    countOrder: json['count_order'] as int? ?? 0,
    rating: (json['rating'] as num? ?? 0).toDouble(),
    isActive: json['is_active'] as bool? ?? true,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'].toString())
        : DateTime.now(),
    updatedAt: json['updated_at'] != null
        ? DateTime.parse(json['updated_at'].toString())
        : null,
    searchVector: json['search_vector'] ?? '',
    tubnailModel: json['media'] != null
        ? MediaDetailModel.fromJson(json['media'] as Map<String, dynamic>)
        : null,
    brandModel: json['brand'] != null
        ? BrandModel.fromJson(json['brand'] as Map<String, dynamic>)
        : null,
    currencyModel: ProductCurrencyModel.fromJson(
      json['currency'] as Map<String, dynamic>,
    ),
  );
}
