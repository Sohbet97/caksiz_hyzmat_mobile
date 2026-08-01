import 'dart:ui' show Locale;

import 'package:equatable/equatable.dart';
import 'package:mobile/core/utils/models/media_model.dart';

int _parseId(dynamic value) =>
    value is String ? int.parse(value) : value as int;

final class BannerModel extends Equatable {
  final int id;
  final int? mediaId;
  final String titleTm;
  final String titleRu;
  final String titleEn;
  final String linkType;
  final String? linkValue;
  final String position;
  final bool isActive;
  final int sortOrder;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final MediaDetailModel? media;

  const BannerModel({
    required this.id,
    this.mediaId,
    required this.titleTm,
    required this.titleRu,
    required this.titleEn,
    required this.linkType,
    this.linkValue,
    required this.position,
    required this.isActive,
    required this.sortOrder,
    this.startDate,
    this.endDate,
    required this.createdAt,
    required this.updatedAt,
    this.media,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: _parseId(json['id']),
    mediaId: json['media_id'] != null ? _parseId(json['media_id']) : null,
    titleTm: json['title_tm'] ?? '',
    titleRu: json['title_ru'] ?? '',
    titleEn: json['title_en'] ?? '',
    linkType: json['link_type'] as String? ?? '',
    linkValue: json['link_value'] as String?,
    position: json['position'] as String? ?? '',
    isActive: json['is_active'] as bool? ?? true,
    sortOrder: json['sort_order'] as int? ?? 0,
    startDate: json['start_date'] != null
        ? DateTime.tryParse(json['start_date'] as String)
        : null,
    endDate: json['end_date'] != null
        ? DateTime.tryParse(json['end_date'] as String)
        : null,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'].toString())
        : DateTime.now(),
    updatedAt: json['updated_at'] != null
        ? DateTime.parse(json['updated_at'].toString())
        : DateTime.now(),
    media: json['media'] != null
        ? MediaDetailModel.fromJson(json['media'] as Map<String, dynamic>)
        : null,
  );

  /// True when active and within [startDate, endDate], as an extra guard
  /// in case the API returns banners outside their scheduled window.
  bool get isCurrentlyActive {
    if (!isActive) return false;
    final now = DateTime.now();
    if (startDate != null && now.isBefore(startDate!)) return false;
    if (endDate != null && now.isAfter(endDate!)) return false;
    return true;
  }

  @override
  List<Object?> get props => [
    id,
    mediaId,
    titleTm,
    titleRu,
    titleEn,
    linkType,
    linkValue,
    position,
    isActive,
    sortOrder,
    startDate,
    endDate,
    createdAt,
    updatedAt,
    media,
  ];
}

extension BannerLocalization on BannerModel {
  String localizedTitle(Locale locale) {
    return switch (locale.languageCode) {
      'tm' => titleTm,
      'en' => titleEn.isNotEmpty ? titleEn : titleRu,
      _ => titleRu,
    };
  }
}
