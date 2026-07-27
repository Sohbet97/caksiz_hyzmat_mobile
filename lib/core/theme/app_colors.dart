import 'package:flutter/material.dart';

/// Custom color palette exposed via [ThemeExtension].
/// Access with `Theme.of(context).extension<AppColors>()!`.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.primaryLight,
    required this.primaryDark,
    required this.onPrimary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.error,
    required this.success,
    required this.warning,
    required this.info,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.border,
    required this.divider,
    required this.shadow,
    required this.overlay,
  });

  final Color primary;
  final Color primaryLight;
  final Color primaryDark;
  final Color onPrimary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color error;
  final Color success;
  final Color warning;
  final Color info;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color border;
  final Color divider;
  final Color shadow;
  final Color overlay;

  /// Light theme palette. Primary orange matches the Temu-style brand accent.
  static const light = AppColors(
    primary: Color(0xFFFF6100),
    primaryLight: Color(0xFFFF8A3D),
    primaryDark: Color(0xFFE04E00),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFFFA136),
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFF7F7F8),
    surfaceVariant: Color(0xFFEFEFEF),
    error: Color(0xFFE53935),
    success: Color(0xFF43A047),
    warning: Color(0xFFFFB300),
    info: Color(0xFF1E88E5),
    textPrimary: Color(0xFF1A1A1A),
    textSecondary: Color(0xFF6B6B6B),
    textDisabled: Color(0xFFB0B0B0),
    border: Color(0xFFE0E0E0),
    divider: Color(0xFFEDEDED),
    shadow: Color(0x1A000000),
    overlay: Color(0x66000000),
  );

  /// Dark theme palette. Same brand orange, inverted surfaces/text.
  static const dark = AppColors(
    primary: Color(0xFFFF6100),
    primaryLight: Color(0xFFFF8A3D),
    primaryDark: Color(0xFFE04E00),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFFFA136),
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
    surfaceVariant: Color(0xFF2A2A2A),
    error: Color(0xFFEF5350),
    success: Color(0xFF66BB6A),
    warning: Color(0xFFFFCA28),
    info: Color(0xFF42A5F5),
    textPrimary: Color(0xFFF5F5F5),
    textSecondary: Color(0xFFB0B0B0),
    textDisabled: Color(0xFF6B6B6B),
    border: Color(0xFF2C2C2C),
    divider: Color(0xFF2C2C2C),
    shadow: Color(0x66000000),
    overlay: Color(0x99000000),
  );

  @override
  AppColors copyWith({
    Color? primary,
    Color? primaryLight,
    Color? primaryDark,
    Color? onPrimary,
    Color? secondary,
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? error,
    Color? success,
    Color? warning,
    Color? info,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDisabled,
    Color? border,
    Color? divider,
    Color? shadow,
    Color? overlay,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryDark: primaryDark ?? this.primaryDark,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textDisabled: textDisabled ?? this.textDisabled,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      shadow: shadow ?? this.shadow,
      overlay: overlay ?? this.overlay,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
    );
  }
}
