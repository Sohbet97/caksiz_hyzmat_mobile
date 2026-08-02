import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../generated/l10n.dart';

class ProductGridEmptyWidget extends StatelessWidget {
  const ProductGridEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          S.of(context).productEmpty,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: colors.textSecondary),
        ),
      ),
    );
  }
}