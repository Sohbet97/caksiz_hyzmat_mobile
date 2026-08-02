import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/generated/l10n.dart';

import '../../../../core/router/app_router.dart';

class MyProductSearchWidget extends StatefulWidget {
  const MyProductSearchWidget({super.key});

  @override
  State<MyProductSearchWidget> createState() => _MyProductSearchWidgetState();
}

class _MyProductSearchWidgetState extends State<MyProductSearchWidget> {
  Timer? _timer;
  int _hintIndex = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!mounted) return;
      setState(() => _hintIndex++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final localization = S.of(context);
    final hints = [
      localization.search,
      localization.skidki,
      localization.news_added,
      localization.mugt_dostawkalar,
      localization.gunun_arzanlasygy,
    ];
    final hint = hints[_hintIndex % hints.length];

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          context.push(AppRoutes.productSearchScreen);
        },
        child: Container(
          height: 44,
          padding: const EdgeInsets.only(left: 14, right: 4),
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colors.border),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: colors.textSecondary, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: ClipRect(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: Text(
                      hint,
                      key: ValueKey(_hintIndex),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.textDisabled,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
