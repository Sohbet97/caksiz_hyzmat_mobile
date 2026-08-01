import 'package:mobile/features/banners/model/banner_model.dart';

class BannerResponse {
  final List<BannerModel> banners;
  final BannerResponseMeta meta;

  BannerResponse({required this.banners, required this.meta});

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      BannerResponse(
        banners: (json['data'] as List<dynamic>? ?? [])
            .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        meta: BannerResponseMeta.fromJson(json['meta'] as Map<String, dynamic>),
      );
}

class BannerResponseMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  BannerResponseMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory BannerResponseMeta.fromJson(Map<String, dynamic> json) =>
      BannerResponseMeta(
        total: json['total'] as int? ?? 0,
        page: json['page'] as int? ?? 1,
        limit: json['limit'] as int? ?? 0,
        totalPages: json['totalPages'] as int? ?? 0,
      );
}
