import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../generated/l10n.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../products/models/product_filter_model.dart';
import '../../products/presentation/widgets/products_grid_section.dart';
import 'widgets/person_grid_widget.dart';
import 'widgets/person_guest_header_widget.dart';
import 'widgets/person_member_header_widget.dart';
import 'widgets/person_menu_list_widget.dart';

import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: ProductsGridSection(
          filter: const ProductFilterModel(),
          leadingSlivers: [
            SliverToBoxAdapter(
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Container(
                    color: colors.background,
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    child: state is AuthSuccess
                        ? PersonMemberHeaderWidget(person: state.person)
                        : PersonGuestHeaderWidget(
                            onLoginTap: () => context.push(AppRoutes.auth),
                          ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            const SliverToBoxAdapter(child: PersonMenuListWidget()),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            const SliverToBoxAdapter(child: PersonGridWidget()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  S.of(context).maslahat_berilyanler,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
