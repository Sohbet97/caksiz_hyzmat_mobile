class ProductCurrencyModel {
  final int id;
  final String code;
  final String name;
  final bool isActive;
  final DateTime createdAt;

  ProductCurrencyModel({
    required this.id,
    required this.code,
    required this.name,
    required this.isActive,
    required this.createdAt,
  });

  factory ProductCurrencyModel.fromJson(Map<String, dynamic> json) =>
      ProductCurrencyModel(
        id: json['id'] as int,
        code: json['code'] ?? '',
        name: json['name'] ?? '',
        isActive: json['is_active'] as bool,
        createdAt: DateTime.parse(json['created_at'].toString()),
      );
}
