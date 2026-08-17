import 'dart:ui' show Locale;

import 'package:equatable/equatable.dart';
import 'package:mobile/core/utils/models/media_model.dart';

int _parseId(dynamic value) =>
    value is String ? int.parse(value) : value as int;

int? _parseIdOrNull(dynamic value) =>
    value == null ? null : _parseId(value);
   
    String? _parseStringOrFirstOfList(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is List && value.isNotEmpty) return value.first.toString();
  if (value is List) return null;
  return value.toString();
}

double? _parseDoubleOrNull(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}

final class SchoolDetailCityModel extends Equatable {
  final int id;
  final String nameTm;
  final String nameRu;
  final String? nameEn;
  final String? region;
  final bool isActive;
  final int sortOrder;
  final DateTime? createdAt;

  const SchoolDetailCityModel({
    required this.id,
    required this.nameTm,
    required this.nameRu,
    this.nameEn,
    this.region,
    this.isActive = true,
    this.sortOrder = 0,
    this.createdAt,
  });

  factory SchoolDetailCityModel.fromJson(Map<String, dynamic> json) {
    return SchoolDetailCityModel(
      id: _parseId(json['id']),
      nameTm: json['name_tm'] as String? ?? '',
      nameRu: json['name_ru'] as String? ?? '',
      nameEn: json['name_en'] as String?,
      region: json['region'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      sortOrder: json['sort_order'] as int? ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    nameTm,
    nameRu,
    nameEn,
    region,
    isActive,
    sortOrder,
    createdAt,
  ];
}

final class CurrencyModel extends Equatable {
  final int id;
  final String name;
  final String code;
  final bool isActive;
  final DateTime? createdAt;

  const CurrencyModel({
    required this.id,
    required this.name,
    required this.code,
    this.isActive = true,
    this.createdAt,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: _parseId(json['id']),
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [id, name, code, isActive, createdAt];
}

final class SchoolGalleryItemModel extends Equatable {
  final int id;
  final int schoolId;
  final int mediaId;
  final MediaDetailModel? media;
  final int sortOrder;
  final DateTime? createdAt;

  const SchoolGalleryItemModel({
    required this.id,
    required this.schoolId,
    required this.mediaId,
    this.media,
    this.sortOrder = 0,
    this.createdAt,
  });

  factory SchoolGalleryItemModel.fromJson(Map<String, dynamic> json) {
    return SchoolGalleryItemModel(
      id: _parseId(json['id']),
      schoolId: _parseId(json['school_id']),
      mediaId: _parseId(json['media_id']),
      media: json['media'] != null
          ? MediaDetailModel.fromJson(json['media'] as Map<String, dynamic>)
          : null,
      sortOrder: json['sort_order'] as int? ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    schoolId,
    mediaId,
    media,
    sortOrder,
    createdAt,
  ];
}

final class DocumentModel extends Equatable {
  final int id;
  final String nameTm;
  final String nameRu;
  final String? nameEn;
  final String? fieldType;
  final bool isRequired;
  final int sortOrder;
  final DateTime? createdAt;

  const DocumentModel({
    required this.id,
    required this.nameTm,
    required this.nameRu,
    this.nameEn,
    this.fieldType,
    this.isRequired = false,
    this.sortOrder = 0,
    this.createdAt,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: _parseId(json['id']),
      nameTm: json['name_tm'] as String? ?? '',
      nameRu: json['name_ru'] as String? ?? '',
      nameEn: json['name_en'] as String?,
      fieldType: json['field_type'] as String?,
      isRequired: json['is_required'] as bool? ?? false,
      sortOrder: json['sort_order'] as int? ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    nameTm,
    nameRu,
    nameEn,
    fieldType,
    isRequired,
    sortOrder,
    createdAt,
  ];
}

final class SchoolDocumentRequirementModel extends Equatable {
  final int id;
  final int schoolId;
  final int documentId;
  final DocumentModel? document;
  final DateTime? createdAt;

  const SchoolDocumentRequirementModel({
    required this.id,
    required this.schoolId,
    required this.documentId,
    this.document,
    this.createdAt,
  });

  factory SchoolDocumentRequirementModel.fromJson(Map<String, dynamic> json) {
    return SchoolDocumentRequirementModel(
      id: _parseId(json['id']),
      schoolId: _parseId(json['school_id']),
      documentId: _parseId(json['document_id']),
      document: json['document'] != null
          ? DocumentModel.fromJson(json['document'] as Map<String, dynamic>)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [id, schoolId, documentId, document, createdAt];
}

final class KafedraModel extends Equatable {
  final int id;
  final String nameTm;
  final String nameRu;
  final String? nameEn;
  final int? thumbnailMediaId;
  final MediaDetailModel? thumbnailMedia;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const KafedraModel({
    required this.id,
    required this.nameTm,
    required this.nameRu,
    this.nameEn,
    this.thumbnailMediaId,
    this.thumbnailMedia,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory KafedraModel.fromJson(Map<String, dynamic> json) {
    return KafedraModel(
      id: _parseId(json['id']),
      nameTm: json['name_tm'] as String? ?? '',
      nameRu: json['name_ru'] as String? ?? '',
      nameEn: json['name_en'] as String?,
      thumbnailMediaId: _parseIdOrNull(json['thumbnail_media_id']),
      thumbnailMedia: json['thumbnail_media'] != null
          ? MediaDetailModel.fromJson(
              json['thumbnail_media'] as Map<String, dynamic>,
            )
          : null,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    nameTm,
    nameRu,
    nameEn,
    thumbnailMediaId,
    thumbnailMedia,
    isActive,
    createdAt,
    updatedAt,
  ];
}

final class SchoolKafedraModel extends Equatable {
  final int id;
  final int schoolId;
  final int kafedraId;
  final KafedraModel? kafedra;
  final num amount;
  final int? currencyId;
  final CurrencyModel? currency;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SchoolKafedraModel({
    required this.id,
    required this.schoolId,
    required this.kafedraId,
    this.kafedra,
    required this.amount,
    this.currencyId,
    this.currency,
    this.createdAt,
    this.updatedAt,
  });

  factory SchoolKafedraModel.fromJson(Map<String, dynamic> json) {
    return SchoolKafedraModel(
      id: _parseId(json['id']),
      schoolId: _parseId(json['school_id']),
      kafedraId: _parseId(json['kafedra_id']),
      kafedra: json['kafedra'] != null
          ? KafedraModel.fromJson(json['kafedra'] as Map<String, dynamic>)
          : null,
      amount: _parseDoubleOrNull(json['amount']) ?? 0,
      currencyId: _parseIdOrNull(json['currency_id']),
      currency: json['currency'] != null
          ? CurrencyModel.fromJson(json['currency'] as Map<String, dynamic>)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    schoolId,
    kafedraId,
    kafedra,
    amount,
    currencyId,
    currency,
    createdAt,
    updatedAt,
  ];
}

final class SchoolDetailModel extends Equatable {
  final int id;
  final String nameTm;
  final String nameRu;
  final String? nameEn;
  final String slug;
  final String? descriptionTm;
  final String? descriptionRu;
  final String? descriptionEn;
  final int? thumbnailMediaId;
  final MediaDetailModel? thumbnailMedia;
  final double? latitude;
  final double? longitude;
  final int? cityId;
  final SchoolDetailCityModel? city;
  final String? address;
  final String? phone;
  final String? website;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SchoolGalleryItemModel> gallery;
  final List<SchoolDocumentRequirementModel> documents;
  final List<SchoolKafedraModel> kafedralar;
  final int totalApplicants;

  const SchoolDetailModel({
    required this.id,
    required this.nameTm,
    required this.nameRu,
    this.nameEn,
    required this.slug,
    this.descriptionTm,
    this.descriptionRu,
    this.descriptionEn,
    this.thumbnailMediaId,
    this.thumbnailMedia,
    this.latitude,
    this.longitude,
    this.cityId,
    this.city,
    this.address,
    this.phone,
    this.website,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.gallery = const [],
    this.documents = const [],
    this.kafedralar = const [],
    this.totalApplicants = 0,
  });

  factory SchoolDetailModel.fromJson(Map<String, dynamic> json) {
    return SchoolDetailModel(
      id: _parseId(json['id']),
      nameTm: json['name_tm'] as String? ?? '',
      nameRu: json['name_ru'] as String? ?? '',
      nameEn: json['name_en'] as String?,
      slug: json['slug'] as String? ?? '',
      descriptionTm: json['description_tm'] as String?,
      descriptionRu: json['description_ru'] as String?,
      descriptionEn: json['description_en'] as String?,
      thumbnailMediaId: _parseIdOrNull(json['thumbnail_media_id']),
      thumbnailMedia: json['thumbnail_media'] != null
          ? MediaDetailModel.fromJson(
              json['thumbnail_media'] as Map<String, dynamic>,
            )
          : null,
      latitude: _parseDoubleOrNull(json['latitude']),
      longitude: _parseDoubleOrNull(json['longitude']),
      cityId: _parseIdOrNull(json['city_id']),
      city: json['city'] != null
          ? SchoolDetailCityModel.fromJson(json['city'] as Map<String, dynamic>)
          : null,
      address: _parseStringOrFirstOfList(json['address']),
      phone: _parseStringOrFirstOfList(json['phone']),
      website: _parseStringOrFirstOfList(json['website']),
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      gallery: (json['gallery'] as List<dynamic>? ?? [])
          .map(
            (e) => SchoolGalleryItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      documents: (json['documents'] as List<dynamic>? ?? [])
          .map(
            (e) => SchoolDocumentRequirementModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      kafedralar: (json['kafedralar'] as List<dynamic>? ?? [])
          .map((e) => SchoolKafedraModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalApplicants: json['total_applicants'] as int? ?? 0,
    );
  }

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
    thumbnailMediaId,
    thumbnailMedia,
    latitude,
    longitude,
    cityId,
    city,
    address,
    phone,
    website,
    isActive,
    createdAt,
    updatedAt,
    gallery,
    documents,
    kafedralar,
    totalApplicants,
  ];
}

extension SchoolDetailLocalization on SchoolDetailModel {
  String localizedName(Locale locale) {
    return switch (locale.languageCode) {
      'tm' => nameTm,
      'en' => nameEn ?? nameRu,
      _ => nameRu,
    };
  }

  String? localizedDescription(Locale locale) {
    return switch (locale.languageCode) {
      'tm' => descriptionTm,
      'en' => descriptionEn ?? descriptionRu,
      _ => descriptionRu,
    };
  }
}

extension SchoolDetailCityLocalization on SchoolDetailCityModel {
  String localizedName(Locale locale) {
    return switch (locale.languageCode) {
      'tm' => nameTm,
      'en' => nameEn ?? nameRu,
      _ => nameRu,
    };
  }
}

extension KafedraLocalization on KafedraModel {
  String localizedName(Locale locale) {
    return switch (locale.languageCode) {
      'tm' => nameTm,
      'en' => nameEn ?? nameRu,
      _ => nameRu,
    };
  }
}

extension DocumentLocalization on DocumentModel {
  String localizedName(Locale locale) {
    return switch (locale.languageCode) {
      'tm' => nameTm,
      'en' => nameEn ?? nameRu,
      _ => nameRu,
    };
  }
}