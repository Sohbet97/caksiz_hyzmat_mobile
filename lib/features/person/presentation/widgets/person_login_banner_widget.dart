import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';

class PersonLoginBannerWidget extends StatelessWidget {
  const PersonLoginBannerWidget({
    super.key,
    required this.onLoginTap,
    this.middleContent,
  });

  final VoidCallback onLoginTap;
  final Widget? middleContent;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final localization = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          localization.personLoginTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        if (middleContent != null) ...[
          const SizedBox(height: 20),
          middleContent!,
        ],
        const SizedBox(height: 24),
        SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: onLoginTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(localization.personLoginButton),
          ),
        ),
      ],
    );
  }
}