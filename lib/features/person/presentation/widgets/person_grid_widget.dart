import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';
import 'person_grid_item_widget.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';

class PersonGridWidget extends StatelessWidget {
  const PersonGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final localization = S.of(context);

    final items = [
      (Icons.settings_outlined, localization.personSettings),
      (Icons.headset_mic_outlined, localization.personSupport),
      (Icons.star_border_outlined, localization.personReviews),
      (Icons.history, localization.personHistory),
      (Icons.location_on_outlined, localization.personAddresses),
      (Icons.storefront_outlined, localization.personFollowing),
    ];

    return Container(
      color: colors.background,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items
              .map(
                (item) => SizedBox(
                  width: 78,
                  child: PersonGridItemWidget(
                    icon: item.$1,
                    title: item.$2,
                    onTap: () => context.push(AppRoutes.settings),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}