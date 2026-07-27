part of 'main_bloc.dart';

@immutable
class MainState {
  const MainState({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('en'),
    this.navigationIndex = 0,
    this.isLoading = true,
  });

  final ThemeMode themeMode;
  final Locale locale;
  final int navigationIndex;
  final bool isLoading;

  MainState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    int? navigationIndex,
    bool? isLoading,
  }) {
    return MainState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      navigationIndex: navigationIndex ?? this.navigationIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
