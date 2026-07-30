import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/features/category/extensions/category_localization_extension.dart';
import 'package:mobile/features/category/models/category_model.dart';

class CategorySidebarItem extends StatelessWidget {
  const CategorySidebarItem({
    super.key,
    required this.category,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final CategoryModel category;
  final int language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final mediaUrl = category.media?.fullUrl;

    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected ? colors.background : colors.surface,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: colors.primary, width: 2)
                    : null,
              ),
              child: ClipOval(
                child: ColoredBox(
                  color: colors.surfaceVariant,
                  child: mediaUrl != null
                      ? Image.network(
                          mediaUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.category_outlined,
                            color: colors.textSecondary,
                          ),
                        )
                      : Icon(
                          Icons.category_outlined,
                          color: colors.textSecondary,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.localizedName(language),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isSelected ? colors.primary : colors.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
