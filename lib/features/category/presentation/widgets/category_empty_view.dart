import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';

import '../../../../generated/l10n.dart';

class CategoryEmptyView extends StatelessWidget {
  const CategoryEmptyView({super.key, this.onRefresh});

  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primaryLight.withValues(alpha: 0.12),
              ),
              child: Icon(
                Icons.category_outlined,
                size: 44,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).categoriesEmpty,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).categoryEmptyDesc,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall,
            ),
            if (onRefresh != null) ...[
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh, size: 18),
                label: Text(S.of(context).retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
