import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';

class CategorySubcategoryEmptyView extends StatelessWidget {
  const CategorySubcategoryEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primaryLight.withValues(alpha: 0.12),
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 38,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Здесь пока пусто',
              textAlign: TextAlign.center,
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              'В этой категории пока нет подкатегорий или товаров',
              textAlign: TextAlign.center,
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
