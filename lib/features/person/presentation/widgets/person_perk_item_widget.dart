import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class PersonPerkItemWidget extends StatelessWidget {
  const PersonPerkItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colors.primaryLight.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 22, color: colors.primary),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.labelMedium?.copyWith(color: colors.textPrimary),
        ),
        const SizedBox(height: 2),
        Text(
          description,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.labelSmall?.copyWith(color: colors.textSecondary),
        ),
      ],
    );
  }
}