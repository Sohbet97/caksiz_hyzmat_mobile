import 'dart:ui' show Locale;

import 'package:equatable/equatable.dart';

enum SchoolMediaType {
  image,
  video,
  file;

  static SchoolMediaType? fromJson(String? value) {
    return switch (value) {
      'image' => SchoolMediaType.image,
      'video' => SchoolMediaType.video,
      'file' => SchoolMediaType.file,
      _ => null,
    };
  }
}

final class SchoolMediaModel extends Equatable {
  final int id;
  final SchoolMediaType? mediaType;
  final String fileName;
  final String url;

  const SchoolMediaModel({
    required this.id,
    required this.mediaType,
    required this.fileName,
    required this.url,
  });

  factory SchoolMediaModel.fromJson(Map<String, dynamic> json) {
    return SchoolMediaModel(
      id: json['id'] as int,
      mediaType: SchoolMediaType.fromJson(json['media_type'] as String?),
      fileName: json['file_name'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [id, mediaType, fileName, url];
}

final class SchoolCityModel extends Equatable {
  final int id;
  final String nameTm;
  final String nameRu;
  final String? region;

  const SchoolCityModel({
    required this.id,
    required this.nameTm,
    required this.nameRu,
    this.region,
  });

  factory SchoolCityModel.fromJson(Map<String, dynamic> json) {
    return SchoolCityModel(
      id: json['id'] as int,
      nameTm: json['name_tm'] as String? ?? '',
      nameRu: json['name_ru'] as String? ?? '',
      region: json['region'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, nameTm, nameRu, region];
}

final class SchoolModel extends Equatable {
  final int id;
  final String nameTm;
  final String nameRu;
  final String? nameEn;
  final String slug;
  final String? descriptionTm;
  final String? descriptionRu;
  final String? descriptionEn;
  final int? thumbnailMediaId;
  final SchoolMediaModel? thumbnailMedia;
  final double? latitude;
  final double? longitude;
  final int? cityId;
  final SchoolCityModel? city;
  final String? address;
  final String? phone;
  final String? website;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SchoolModel({
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
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
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
          ? SchoolMediaModel.fromJson(
              json['thumbnail_media'] as Map<String, dynamic>,
            )
          : null,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      cityId: json['city_id'] as int?,
      city: json['city'] != null
          ? SchoolCityModel.fromJson(json['city'] as Map<String, dynamic>)
          : null,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
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
  ];
}

extension SchoolLocalization on SchoolModel {
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

extension SchoolCityLocalization on SchoolCityModel {
  String localizedName(Locale locale) {
    return switch (locale.languageCode) {
      'tm' => nameTm,
      _ => nameRu,
    };
  }
}
