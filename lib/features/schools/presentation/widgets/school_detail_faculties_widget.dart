import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/school_detail_model.dart';

class SchoolDetailFacultiesWidget extends StatelessWidget {
  const SchoolDetailFacultiesWidget({super.key, required this.kafedralar});

  final List<SchoolKafedraModel> kafedralar;

  @override
  Widget build(BuildContext context) {
    if (kafedralar.isEmpty) return const SizedBox.shrink();

    final colors = Theme.of(context).extension<AppColors>()!;
    final locale = Localizations.localeOf(context);
    final localization = S.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization.schoolDetailFaculties,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 124,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: kafedralar.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final k = kafedralar[index];
                final name = k.kafedra?.localizedName(locale) ?? '';
                return Container(
                  width: 110,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: colors.primary.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Image.asset('assets/images/faculty.png'),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${k.amount.toStringAsFixed(0)} ${k.currency?.code ?? ''}',
                        style: TextStyle(
                          fontSize: 11,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}