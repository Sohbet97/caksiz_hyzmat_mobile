import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';

import '../../../../generated/l10n.dart';

class HomeErrorWidget extends StatelessWidget {
  const HomeErrorWidget({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.light.primary.withOpacity(0.2),
              ),
              child: Icon(
                Icons.error_outline,
                color: AppColors.light.primary,
                size: 35,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(localization.nasazlyk_yuze_cykdy),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: onTap, child: Text(localization.retry)),
        ],
      ),
    );
  }
}
