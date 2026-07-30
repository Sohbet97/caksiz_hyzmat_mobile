import 'package:flutter/material.dart';

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
            icon: Icons.receipt_long_outlined,
            title: localization.personOrders,
            onTap: () {},
          ),
          Divider(height: 1, color: colors.divider, indent: 20, endIndent: 20),
          PersonMenuItemWidget(
            icon: Icons.chat_bubble_outline,
            title: localization.personMessages,
            onTap: () {},
          ),
          Divider(height: 1, color: colors.divider, indent: 20, endIndent: 20),
          PersonMenuItemWidget(
            icon: Icons.confirmation_number_outlined,
            title: localization.personCoupons,
            onTap: () {},
          ),
          Divider(height: 1, color: colors.divider, indent: 20, endIndent: 20),
          PersonMenuItemWidget(
            icon: Icons.account_balance_wallet_outlined,
            title: localization.personBalance,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}