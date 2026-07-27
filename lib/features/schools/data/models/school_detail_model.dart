import 'dart:ui' show Locale;

import 'package:equatable/equatable.dart';

final class SchoolDetailMediaModel extends Equatable {
  final int id;
  final String? entityType;
  final int? entityId;
  final String? mediaType;
  final String? collectionName;
  final String fileName;
  final String? originalName;
  final String? filePath;
  final String url;
  final String? mimeType;
  final int? sizeBytes;
  final int? width;
  final int? height;
  final int? durationSec;
  final String? thumbnailUrl;
  final String? altText;
  final int sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SchoolDetailMediaModel({
    required this.id,
    this.entityType,
    this.entityId,
    this.mediaType,
    this.collectionName,
    required this.fileName,
    this.originalName,
    this.filePath,
    required this.url,
    this.mimeType,
    this.sizeBytes,
    this.width,
    this.height,
    this.durationSec,
    this.thumbnailUrl,
    this.altText,
    this.sortOrder = 0,
    this.createdAt,
    this.updatedAt,
  });

  factory SchoolDetailMediaModel.fromJson(Map<String, dynamic> json) {
    return SchoolDetailMediaModel(
      id: json['id'] as int,
      entityType: json['entity_type'] as String?,
      entityId: json['entity_id'] as int?,
      mediaType: json['media_type'] as String?,
      collectionName: json['collection_name'] as String?,
      fileName: json['file_name'] as String? ?? '',
      originalName: json['original_name'] as String?,
      filePath: json['file_path'] as String?,
      url: json['url'] as String? ?? '',
      mimeType: json['mime_type'] as String?,
      sizeBytes: json['size_bytes'] as int?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      durationSec: json['duration_sec'] as int?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      altText: json['alt_text'] as String?,
      sortOrder: json['sort_order'] as int? ?? 0,
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
    entityType,
    entityId,
    mediaType,
    collectionName,
    fileName,
    originalName,
    filePath,
    url,
    mimeType,
    sizeBytes,
    width,
    height,
    durationSec,
    thumbnailUrl,
    altText,
    sortOrder,
    createdAt,
    updatedAt,
  ];
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
      id: json['id'] as int,
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
      id: json['id'] as int,
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
  final SchoolDetailMediaModel? media;
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
      id: json['id'] as int,
      schoolId: json['school_id'] as int,
      mediaId: json['media_id'] as int,
      media: json['media'] != null
          ? SchoolDetailMediaModel.fromJson(json['media'] as Map<String, dynamic>)
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
      id: json['id'] as int,
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
      id: json['id'] as int,
      schoolId: json['school_id'] as int,
      documentId: json['document_id'] as int,
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
  final SchoolDetailMediaModel? thumbnailMedia;
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
      id: json['id'] as int,
      nameTm: json['name_tm'] as String? ?? '',
      nameRu: json['name_ru'] as String? ?? '',
      nameEn: json['name_en'] as String?,
      thumbnailMediaId: json['thumbnail_media_id'] as int?,
      thumbnailMedia: json['thumbnail_media'] != null
          ? SchoolDetailMediaModel.fromJson(
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
      id: json['id'] as int,
      schoolId: json['school_id'] as int,
      kafedraId: json['kafedra_id'] as int,
      kafedra: json['kafedra'] != null
          ? KafedraModel.fromJson(json['kafedra'] as Map<String, dynamic>)
          : null,
      amount: json['amount'] as num? ?? 0,
      currencyId: json['currency_id'] as int?,
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
  final SchoolDetailMediaModel? thumbnailMedia;
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
      id: json['id'] as int,
      nameTm: json['name_tm'] as String? ?? '',
      nameRu: json['name_ru'] as String? ?? '',
      nameEn: json['name_en'] as String?,
      slug: json['slug'] as String? ?? '',
      descriptionTm: json['description_tm'] as String?,
      descriptionRu: json['description_ru'] as String?,
      descriptionEn: json['description_en'] as String?,
      thumbnailMediaId: json['thumbnail_media_id'] as int?,
      thumbnailMedia: json['thumbnail_media'] != null
          ? SchoolDetailMediaModel.fromJson(
              json['thumbnail_media'] as Map<String, dynamic>,
            )
          : null,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      cityId: json['city_id'] as int?,
      city: json['city'] != null
          ? SchoolDetailCityModel.fromJson(json['city'] as Map<String, dynamic>)
          : null,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
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
