import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';
import 'person_menu_item_widget.dart';

class PersonMenuListWidget extends StatelessWidget {
  const PersonMenuListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final localization = S.of(context);

    return Container(
      color: colors.background,
      child: Column(
        children: [
          PersonMenuItemWidget(
            iconAsset: 'assets/images/cart.gif',
            title: localization.personOrders,
            onTap: () => context.push(AppRoutes.orders),
          ),
          Divider(height: 1, color: colors.divider, indent: 20, endIndent: 20),
          PersonMenuItemWidget(
            iconAsset: 'assets/images/email.gif',
            title: localization.personMessages,
            onTap: () => context.push(AppRoutes.messages),
          ),
          Divider(height: 1, color: colors.divider, indent: 20, endIndent: 20),
          PersonMenuItemWidget(
            iconAsset: 'assets/images/favorite.gif',
            title: localization.personCoupons,
            onTap: () => context.push(AppRoutes.favorites),
          ),
          Divider(height: 1, color: colors.divider, indent: 20, endIndent: 20),
          PersonMenuItemWidget(
            iconAsset: 'assets/images/coin.gif',
            title: localization.personBalance,
            onTap: () => context.push(AppRoutes.coupons),
          ),
        ],
      ),
    );
  }
}