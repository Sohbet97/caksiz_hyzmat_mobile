import 'package:equatable/equatable.dart';

int _parseInt(dynamic value) =>
    value is String ? int.parse(value) : value as int;

int? _parseNullableInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}

final class PersonModel extends Equatable {
  final int id;
  final String fullName;
  final String? phoneNumber;
  final String? email;
  final String? googleId;
  final bool isPhoneVerified;
  final bool isEmailVerified;
  final int? avatarMediaId;
  final String? avatarExternalUrl;
  final String? fcmToken;
  final String userType;
  final bool isOnline;
  final bool isActive;
  final DateTime? lastSeenAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const PersonModel({
    required this.id,
    required this.fullName,
    this.phoneNumber,
    this.email,
    this.googleId,
    required this.isPhoneVerified,
    required this.isEmailVerified,
    this.avatarMediaId,
    this.avatarExternalUrl,
    this.fcmToken,
    required this.userType,
    required this.isOnline,
    required this.isActive,
    this.lastSeenAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
    id: _parseInt(json['id']),
    fullName: json['full_name'] as String? ?? '',
    phoneNumber: json['phone_number'] as String?,
    email: json['email'] as String?,
    googleId: json['google_id'] as String?,
    isPhoneVerified: json['is_phone_verified'] as bool? ?? false,
    isEmailVerified: json['is_email_verified'] as bool? ?? false,
    avatarMediaId: _parseNullableInt(json['avatar_media_id']),
    avatarExternalUrl: json['avatar_external_url'] as String?,
    fcmToken: json['fcm_token'] as String?,
    userType: json['user_type'] as String? ?? '',
    isOnline: json['is_online'] as bool? ?? false,
    isActive: json['is_active'] as bool? ?? true,
    lastSeenAt: json['last_seen_at'] != null
        ? DateTime.parse(json['last_seen_at'].toString())
        : null,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'].toString())
        : DateTime.now(),
    updatedAt: json['updated_at'] != null
        ? DateTime.parse(json['updated_at'].toString())
        : null,
  );

  @override
  List<Object?> get props => [
    id,
    fullName,
    phoneNumber,
    email,
    googleId,
    isPhoneVerified,
    isEmailVerified,
    avatarMediaId,
    avatarExternalUrl,
    fcmToken,
    userType,
    isOnline,
    isActive,
    lastSeenAt,
    createdAt,
    updatedAt,
  ];
}
