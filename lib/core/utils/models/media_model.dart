import 'package:equatable/equatable.dart';
import 'package:mobile/core/network/api_client.dart';

const String mediaUrl = 'https://caksizhyzmat.com';

final class MediaDetailModel extends Equatable {
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

  const MediaDetailModel({
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

  factory MediaDetailModel.fromJson(Map<String, dynamic> json) {
    return MediaDetailModel(
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

  String get fullUrl {
    if (url.startsWith('http://') || url.startsWith('https://')) return url;
    final origin = ApiClient.baseUrl.replaceFirst(RegExp(r'/api/?$'), '');
    return '$origin$url';
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entity_type': entityType,
      'entity_id': entityId,
      'media_type': mediaType,
      'collection_name': collectionName,
      'file_name': fileName,
      'original_name': originalName,
      'file_path': filePath,
      'url': url,
      'mime_type': mimeType,
      'size_bytes': sizeBytes,
      'width': width,
      'height': height,
      'duration_sec': durationSec,
      'thumbnail_url': thumbnailUrl,
      'alt_text': altText,
      'sort_order': sortOrder,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
