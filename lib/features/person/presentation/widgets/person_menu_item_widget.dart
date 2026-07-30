import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class PersonMenuItemWidget extends StatelessWidget {
  const PersonMenuItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 22, color: colors.textPrimary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: colors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}