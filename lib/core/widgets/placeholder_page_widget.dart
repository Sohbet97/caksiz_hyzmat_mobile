import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PlaceholderPageWidget extends StatelessWidget {
  const PlaceholderPageWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(title)),
      body: const SizedBox.shrink(),
    );
  }
}