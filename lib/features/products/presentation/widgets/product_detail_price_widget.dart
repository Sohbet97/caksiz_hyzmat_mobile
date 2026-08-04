import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';

class ProductDetailPriceWidget extends StatelessWidget {
  const ProductDetailPriceWidget({
    super.key,
    required this.name,
    required this.brandName,
    required this.salePrice,
    required this.costPrice,
    required this.currencyCode,
    required this.rating,
    required this.soldCount,
  });

  final String name;
  final String? brandName;
  final double salePrice;
  final double costPrice;
  final String currencyCode;
  final double rating;
  final int soldCount;

  int? get _discountPercent {
    if (costPrice > salePrice && costPrice > 0) {
      return (((costPrice - salePrice) / costPrice) * 100).round();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final localization = S.of(context);
    final discount = _discountPercent;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (brandName != null && brandName!.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                brandName!,
                style: textTheme.labelSmall?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ),
          Text(
            name,
            style: textTheme.titleLarge?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${salePrice.toStringAsFixed(2)} $currencyCode',
                style: textTheme.headlineSmall?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (discount != null) ...[
                const SizedBox(width: 10),
                Text(
                  '${costPrice.toStringAsFixed(2)} $currencyCode',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.textSecondary,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: colors.error,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '-$discount%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (rating > 0 || soldCount > 0) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                if (rating > 0) ...[
                  Icon(Icons.star_rounded, size: 16, color: colors.warning),
                  const SizedBox(width: 2),
                  Text(
                    rating.toStringAsFixed(1),
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
                if (rating > 0 && soldCount > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '|',
                      style: TextStyle(color: colors.textSecondary),
                    ),
                  ),
                if (soldCount > 0)
                  Text(
                    '$soldCount ${localization.productSoldSuffix}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}