import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';
import 'person_grid_item_widget.dart';

class PersonGridWidget extends StatelessWidget {
  const PersonGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final localization = S.of(context);

    return Container(
      color: colors.background,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: 78,
              child: PersonGridItemWidget(
                iconAsset: 'assets/images/tools.gif',
                title: localization.personSettings,
                onTap: () => context.push(AppRoutes.settings),
              ),
            ),
            SizedBox(
              width: 78,
              child: PersonGridItemWidget(
                iconAsset: 'assets/images/chat.gif',
                title: localization.personSupport,
                onTap: () => context.push(AppRoutes.support),
              ),
            ),
            SizedBox(
              width: 78,
              child: PersonGridItemWidget(
                iconAsset: 'assets/images/okuwlar.gif',
                title: localization.personReviews,
                onTap: () => context.push(AppRoutes.okuwlar),
              ),
            ),
            SizedBox(
              width: 78,
              child: PersonGridItemWidget(
                iconAsset: 'assets/images/new.gif',
                title: localization.personHistory,
                onTap: () => context.push(AppRoutes.viewed),
              ),
            ),
            SizedBox(
              width: 78,
              child: PersonGridItemWidget(
                iconAsset: 'assets/images/location.gif',
                title: localization.personAddresses,
                onTap: () => context.push(AppRoutes.addresses),
              ),
            ),
            SizedBox(
              width: 78,
              child: PersonGridItemWidget(
                iconAsset: 'assets/images/rekomen.gif',
                title: localization.personFollowing,
                onTap: () => context.push(AppRoutes.following),
              ),
            ),
            SizedBox(
              width: 78,
              child: PersonGridItemWidget(
                iconAsset: 'assets/images/cargo.gif',
                title: localization.personKargo,
                onTap: () => context.push(AppRoutes.cargo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}