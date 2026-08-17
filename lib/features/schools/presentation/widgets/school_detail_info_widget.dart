import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/school_detail_model.dart';

class SchoolDetailInfoWidget extends StatelessWidget {
  const SchoolDetailInfoWidget({super.key, required this.detail});

  final SchoolDetailModel detail;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final localization = S.of(context);

    final rows = <_InfoRow>[
      if (detail.address != null && detail.address!.isNotEmpty)
        _InfoRow(Icons.map_outlined, localization.schoolDetailAddress, detail.address!),
      if (detail.website != null && detail.website!.isNotEmpty)
        _InfoRow(Icons.public, localization.schoolDetailWebsite, detail.website!),
      if (detail.phone != null && detail.phone!.isNotEmpty)
        _InfoRow(Icons.call_outlined, localization.schoolDetailPhone, detail.phone!),
    ];

    if (rows.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization.schoolDetailInfo,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: colors.surfaceVariant.withOpacity(0.6),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                for (var i = 0; i < rows.length; i++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Icon(rows[i].icon, size: 20, color: colors.textSecondary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                rows[i].label,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: colors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                rows[i].value,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: colors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                  if (i != rows.length - 1)
                    Divider(height: 1, color: colors.divider),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow {
  const _InfoRow(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;
}