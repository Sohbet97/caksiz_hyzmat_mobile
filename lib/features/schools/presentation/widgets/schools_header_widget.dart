import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';

class SchoolsHeaderWidget extends StatelessWidget {
  const SchoolsHeaderWidget({
    super.key,
    required this.onSearchChanged,
    required this.onFilterTap,
  });

  final ValueChanged<String> onSearchChanged;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.dark;
    final textTheme = Theme.of(context).textTheme;
    final localization = S.of(context);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.background,
            Color.lerp(colors.background, colors.primaryDark, 0.35)!,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  localization.schoolsTitle,
                  style: textTheme.headlineMedium?.copyWith(
                    color: colors.textPrimary,
                    fontFamily: 'serif',
                    fontWeight: FontWeight.w600,
                    fontSize: 27,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Image.asset('assets/images/cap.png', width: 108, height: 108),
            ],
          ),
         const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: colors.primary.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white.withOpacity(0.85),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: onSearchChanged,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                          cursorColor: colors.primary,
                          decoration: InputDecoration(
                            hintText: localization.searchSchoolsHint,
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            ),
                            filled: false,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            isDense: true,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: onFilterTap,
                customBorder: const CircleBorder(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [colors.primary, colors.primaryDark],
                    ),
                  ),
                  child: Icon(Icons.tune, color: colors.onPrimary, size: 16),
                ),
              ),
            ],
          ),       
          ],
      ),
    );
  }
}