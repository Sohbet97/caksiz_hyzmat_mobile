import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';

class SchoolsSearchBarWidget extends StatelessWidget {
  const SchoolsSearchBarWidget({
    super.key,
    required this.onChanged,
    required this.onFilterTap,
  });

  final ValueChanged<String> onChanged;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.dark;
    final localization = S.of(context);

    return Container(
      color: colors.background,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: colors.primary.withOpacity(0.35),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: colors.primaryLight, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: onChanged,
                      style: TextStyle(color: colors.textPrimary),
                      cursorColor: colors.primary,
                      decoration: InputDecoration(
                        hintText: localization.searchSchoolsHint,
                        hintStyle: TextStyle(color: colors.textSecondary),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: onFilterTap,
            customBorder: const CircleBorder(),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [colors.primary, colors.primaryDark],
                ),
              ),
              child: Icon(Icons.tune, color: colors.onPrimary, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}