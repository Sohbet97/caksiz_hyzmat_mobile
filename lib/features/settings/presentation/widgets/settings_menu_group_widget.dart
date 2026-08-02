import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SettingsMenuGroupWidget extends StatelessWidget {
  const SettingsMenuGroupWidget({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    final List<Widget> items = [];
    for (var i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i != children.length - 1) {
        items.add(
          Divider(height: 1, color: colors.divider, indent: 20, endIndent: 20),
        );
      }
    }

    return Container(
      color: colors.background,
      child: Column(children: items),
    );
  }
}