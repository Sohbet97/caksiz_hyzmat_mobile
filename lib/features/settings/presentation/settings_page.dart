import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../generated/l10n.dart';
import 'widgets/settings_menu_group_widget.dart';
import 'widgets/settings_menu_item_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final localization = S.of(context);

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(title: Text(localization.settingsTitle)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SettingsMenuGroupWidget(
              children: [
                SettingsMenuItemWidget(
                  title: localization.settingsLogin,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 8),
            SettingsMenuGroupWidget(
              children: [
                SettingsMenuItemWidget(
                  title: localization.settingsCountryRegion,
                  trailingText: 'TM',
                  onTap: () {},
                ),
                SettingsMenuItemWidget(
                  title: localization.settingsLanguage,
                  trailingText: 'Türkmençe',
                  onTap: () {},
                ),
                SettingsMenuItemWidget(
                  title: localization.settingsCurrency,
                  trailingText: 'TMT',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 8),
            SettingsMenuGroupWidget(
              children: [
                SettingsMenuItemWidget(
                  title: localization.settingsNotifications,
                  onTap: () {},
                ),
                SettingsMenuItemWidget(
                  title: localization.settingsPrivacy,
                  onTap: () {},
                ),
                SettingsMenuItemWidget(
                  title: localization.settingsPermissions,
                  onTap: () {},
                ),
                SettingsMenuItemWidget(
                  title: localization.settingsSecurityCenter,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 8),
            SettingsMenuGroupWidget(
              children: [
                SettingsMenuItemWidget(
                  title: localization.settingsAboutApp,
                  onTap: () {},
                ),
                SettingsMenuItemWidget(
                  title: localization.settingsContactUs,
                  onTap: () {},
                ),
                SettingsMenuItemWidget(
                  title: localization.settingsContact,
                  onTap: () {},
                ),
                SettingsMenuItemWidget(
                  title: localization.settingsLegal,
                  onTap: () {},
                ),
                SettingsMenuItemWidget(
                  title: localization.settingsShareApp,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}