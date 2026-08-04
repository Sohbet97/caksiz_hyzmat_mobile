import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ProductDetailTrustWidget extends StatelessWidget {
  const ProductDetailTrustWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: _TrustCard(
              colors: colors,
              textTheme: textTheme,
              title: 'Howpsuzlyk',
              lines: const ['Ygtybarly töleg', 'Gizlinlik goragy'],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _TrustCard(
              colors: colors,
              textTheme: textTheme,
              title: 'Eltip bermek',
              lines: const ['Wagtynda gelmese', 'Pul yzyna gaýtarylýar'],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrustCard extends StatelessWidget {
  const _TrustCard({
    required this.colors,
    required this.textTheme,
    required this.title,
    required this.lines,
  });

  final AppColors colors;
  final TextTheme textTheme;
  final String title;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.success,
            ),
          ),
          const SizedBox(height: 6),
          ...lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                children: [
                  Icon(Icons.check, size: 12, color: colors.success),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      line,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}