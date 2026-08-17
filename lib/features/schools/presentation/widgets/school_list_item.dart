import 'package:flutter/material.dart';
import 'package:mobile/features/schools/data/models/school_model.dart';
import '../../../../core/theme/app_colors.dart';

class SchoolListItem extends StatelessWidget {
  const SchoolListItem({
    super.key,
    required this.school,
    this.onTap,
    this.featured = false,
  });

  final SchoolModel school;
  final VoidCallback? onTap;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.light;
    final gold = colors.warning;
    final locale = Localizations.localeOf(context);
    final thumbnailUrl = school.thumbnailMedia?.url;

    final cityName = school.city?.localizedName(locale);
    final region = school.city?.region;
    final locationText = [
      if (cityName != null && cityName.isNotEmpty) cityName,
      if (region != null && region.isNotEmpty) region,
    ].join(', ');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.surface,
            Color.lerp(colors.surface, gold, 0.06)!,
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: featured ? gold.withOpacity(0.6) : colors.border,
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.dark.background,
                        Color.lerp(
                          AppColors.dark.background,
                          AppColors.dark.primaryDark,
                          0.35,
                        )!,
                      ],
                    ),
                    border: Border.all(color: gold.withOpacity(0.4)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: thumbnailUrl != null
                      ? Image.network(
                          thumbnailUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const _Placeholder(),
                        )
                      : const _Placeholder(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [colors.primaryDark, gold],
                        ).createShader(bounds),
                        child: Text(
                          school.localizedName(locale),
                          style: const TextStyle(
                            fontFamily: 'serif',
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (locationText.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          locationText,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 11.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                if (featured) ...[
                  Icon(Icons.star_rounded, color: gold, size: 18),
                  const SizedBox(width: 4),
                ],
                Icon(Icons.chevron_right, size: 18, color: gold),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.account_balance,
        color: AppColors.dark.primaryLight,
        size: 18,
      ),
    );
  }
}