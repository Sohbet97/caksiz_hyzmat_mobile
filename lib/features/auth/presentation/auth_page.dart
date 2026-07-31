import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../generated/l10n.dart';
import 'widgets/auth_option_button_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final localization = S.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.close, color: colors.textPrimary),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                localization.authTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: colors.primary,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 16, color: colors.success),
                  const SizedBox(width: 6),
                  Text(
                    localization.authSecureNote,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.success,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              AuthOptionButtonWidget(
                icon: const Icon(Icons.g_mobiledata, size: 28, color: Colors.white),
                label: localization.authGoogleContinue,
                backgroundColor: colors.info,
                foregroundColor: colors.onPrimary,
                onTap: () {},
              ),
              const SizedBox(height: 16),
              AuthOptionButtonWidget(
                icon: Icon(Icons.email_outlined, color: colors.textPrimary),
                label: localization.authEmailContinue,
                backgroundColor: colors.background,
                foregroundColor: colors.textPrimary,
                borderColor: colors.border,
                onTap: () {},
              ),
              const SizedBox(height: 16),
              AuthOptionButtonWidget(
                icon: Icon(Icons.phone_android_outlined, color: colors.textPrimary),
                label: localization.authPhoneContinue,
                backgroundColor: colors.background,
                foregroundColor: colors.textPrimary,
                borderColor: colors.border,
                onTap: () {},
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  localization.authTroubleLogin,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                    children: [
                      TextSpan(text: '${localization.authTermsPrefix} '),
                      TextSpan(
                        text: localization.authTermsOfUse,
                        style: TextStyle(color: colors.info),
                      ),
                      TextSpan(text: ' ${localization.authAnd} '),
                      TextSpan(
                        text: localization.authPrivacyPolicy,
                        style: TextStyle(color: colors.info),
                      ),
                      TextSpan(text: ' ${localization.authTermsSuffix}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}