import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/storage/settings_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../../products/presentation/widgets/product_person_grid_widget.dart';
import 'widgets/person_grid_widget.dart';
import 'widgets/person_guest_header_widget.dart';
import 'widgets/person_member_header_widget.dart';
import 'widgets/person_menu_list_widget.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late Future<bool> _isRegisteredFuture;

  @override
  void initState() {
    super.initState();
    _isRegisteredFuture = context
        .read<SettingsStorage>()
        .readRegistrationStatus();
  }

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
              FutureBuilder<bool>(
                future: _isRegisteredFuture,
                builder: (context, snapshot) {
                  final isRegistered = snapshot.data ?? false;

                  return Container(
                    color: colors.background,
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    child: isRegistered
                        ? const PersonMemberHeaderWidget()
                        : PersonGuestHeaderWidget(
                            onLoginTap: () => context.push(AppRoutes.auth),
                          ),
                  );
                },
              ),
              const SizedBox(height: 8),
              const PersonMenuListWidget(),
              const SizedBox(height: 8),
              const PersonGridWidget(),
              const SizedBox(height: 8),
              const ProductPersonGridWidget(),
            ],
          ),
        ),
      ),
    );
  }
}