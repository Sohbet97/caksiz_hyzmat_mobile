import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'widgets/person_grid_widget.dart';
import 'widgets/person_login_banner_widget.dart';
import 'widgets/person_menu_list_widget.dart';
import 'widgets/person_perks_row_widget.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: colors.background,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: PersonLoginBannerWidget(
                  onLoginTap: () {
                  },
                  middleContent: const PersonPerksRowWidget(),
                ),
              ),
              const SizedBox(height: 8),
              const PersonMenuListWidget(),
              const SizedBox(height: 8),
              const PersonGridWidget(),
            ],
          ),
        ),
      ),
    );
  }
}