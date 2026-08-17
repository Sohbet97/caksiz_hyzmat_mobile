import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';

class SchoolsAlphabetSidebarWidget extends StatelessWidget {
  const SchoolsAlphabetSidebarWidget({
    super.key,
    required this.availableLetters,
    required this.selectedLetter,
    required this.onLetterTap,
    required this.onAllTap,
  });

  final Set<String> availableLetters;
  final String? selectedLetter;
  final ValueChanged<String> onLetterTap;
  final VoidCallback onAllTap;

  static const _alphabet = [
    'A', 'B', 'Ç', 'D', 'E', 'Ä', 'F', 'G', 'H', 'I', 'J', 'K', 'L',
    'M', 'N', 'O', 'Ö', 'P', 'R', 'S', 'Ş', 'T', 'U', 'Ü', 'W', 'Y', 'Ý', 'Z',
  ];

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.dark;
    final localization = S.of(context);
    final isAllSelected = selectedLetter == null;

    return Container(
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.background,
            Color.lerp(colors.background, colors.primaryDark, 0.35)!,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          _AlphabetChip(
            label: localization.schoolsAllFilter,
            isSelected: isAllSelected,
            isActive: true,
            onTap: onAllTap,
          ),
          const SizedBox(width: 2),
          ..._alphabet.map((letter) {
            final isActive = availableLetters.contains(letter);
            final isSelected = selectedLetter == letter;
            return _AlphabetChip(
              label: letter,
              isSelected: isSelected,
              isActive: isActive,
              onTap: isActive ? () => onLetterTap(letter) : null,
            );
          }),
        ],
      ),
    );
  }
}

class _AlphabetChip extends StatelessWidget {
  const _AlphabetChip({
    required this.label,
    required this.isSelected,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.dark;

    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            color: isSelected ? colors.primary.withOpacity(0.22) : null,
            borderRadius: BorderRadius.circular(14),
            border: isSelected
                ? Border.all(color: colors.primary, width: 1)
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? colors.primary
                  : isActive
                      ? Colors.white
                      : Colors.white.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }
}