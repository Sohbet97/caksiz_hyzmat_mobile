import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/bloc/main_bloc.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/features/home/bloc/bottom_navigation_bloc.dart';

import '../../../../generated/l10n.dart';

class MyNavigationWidget extends StatelessWidget {
  const MyNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, navState) {
          final visible = navState is BottomNavVisible;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: visible ? 60 : 0,
            width: double.infinity,
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: isDarkTheme ? Colors.grey.shade900 : Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
            ),
            child: visible
                ? BlocBuilder<MainBloc, MainState>(
                    builder: (context, mainState) => _BottomNavItemsWidget(
                      currentIndex: mainState.navigationIndex,
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _BottomNavItemsWidget extends StatelessWidget {
  const _BottomNavItemsWidget({required this.currentIndex});
  final int currentIndex;

  void _onNavTap(BuildContext context, int index) {
    if (index == currentIndex) return;
    context.read<MainBloc>().add(NavigationIndexChanged(index));
  }

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);
    return Row(
      children: [
        Expanded(
          child: _NavItem(
            title: localization.home,
            icon: Icons.home,
            onClick: () => _onNavTap(context, 0),

            index: 0,
            showBagde: false,
            total: 0,
            isActive: currentIndex == 0,
          ),
        ),

        Expanded(
          child: _NavItem(
            title: localization.category,
            icon: Icons.manage_search_outlined,
            onClick: () => _onNavTap(context, 1),

            index: 1,
            showBagde: false,
            total: 0,
            isActive: currentIndex == 1,
          ),
        ),

        Expanded(
          child: _NavItem(
            title: localization.person,
            icon: Icons.person_outline,
            onClick: () => _onNavTap(context, 2),

            index: 2,
            showBagde: false,
            total: 0,
            isActive: currentIndex == 2,
          ),
        ),

        Expanded(
          child: _NavItem(
            title: localization.korzina,
            icon: Icons.shopping_cart_outlined,
            onClick: () => _onNavTap(context, 3),

            index: 3,
            showBagde: false,
            total: 0,
            isActive: currentIndex == 3,
          ),
        ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onClick;
  final int index;
  final bool showBagde;
  final int total;
  final bool isActive;
  const _NavItem({
    required this.title,
    required this.icon,
    required this.onClick,
    required this.index,
    required this.showBagde,
    required this.total,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onClick,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                icon,
                size: 24,
                color: isActive
                    ? AppColors.light.primaryLight
                    : Colors.grey.shade500,
              ),

              if (showBagde && total > 0)
                Positioned(
                  right: -7,
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      total > 99 ? '99+' : total.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive
                  ? isDarkTheme
                        ? AppColors.dark.primaryDark
                        : AppColors.light.primaryLight
                  : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
