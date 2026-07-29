import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/features/category/extensions/category_localization_extension.dart';
import 'package:mobile/features/category/models/category_model.dart';

class CategoryBreadcrumb extends StatelessWidget {
  const CategoryBreadcrumb({
    super.key,
    required this.path,
    required this.language,
    required this.onTap,
  });

  final List<CategoryModel> path;
  final int language;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final textStyle = Theme.of(context).textTheme.bodySmall;

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: path.length,
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(
            Icons.chevron_right,
            size: 16,
            color: colors.textDisabled,
          ),
        ),
        itemBuilder: (context, index) {
          final isLast = index == path.length - 1;
          return InkWell(
            onTap: isLast ? null : () => onTap(index),
            child: Center(
              child: Text(
                path[index].localizedName(language),
                style: textStyle?.copyWith(
                  color: isLast ? colors.textPrimary : colors.primary,
                  fontWeight: isLast ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
