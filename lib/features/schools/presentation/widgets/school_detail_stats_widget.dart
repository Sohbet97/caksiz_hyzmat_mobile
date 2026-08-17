import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/school_detail_model.dart';

class SchoolDetailStatsWidget extends StatelessWidget {
  const SchoolDetailStatsWidget({super.key, required this.detail});

  final SchoolDetailModel detail;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final localization = S.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: colors.surfaceVariant.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
            child: Row(
        children: [
          Expanded(
            child: _StatItem(
              icon: Icons.school_outlined,
              value: '${detail.kafedralar.length}',
              label: localization.schoolDetailFaculties,
              colors: colors,
            ),
          ),
          Expanded(
            child: _StatItem(
              icon: Icons.groups_outlined,
              value: '${detail.totalApplicants}',
              label: localization.schoolDetailApplicants,
              colors: colors,
            ),
          ),
          Expanded(
            child: _StatItem(
              icon: Icons.description_outlined,
              value: '${detail.documents.length}',
              label: localization.schoolDetailDocumentsRequired,
              colors: colors,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.colors,
  });

  final IconData icon;
  final String value;
  final String label;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: colors.primary, size: 22),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: colors.textSecondary),
        ),
      ],
    );
  }
}