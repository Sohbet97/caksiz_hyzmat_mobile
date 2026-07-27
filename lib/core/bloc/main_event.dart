part of 'main_bloc.dart';

@immutable
sealed class MainEvent {}

class MainStarted extends MainEvent {}

class ThemeChanged extends MainEvent {
  ThemeChanged(this.themeMode);

  final ThemeMode themeMode;
}

class LanguageChanged extends MainEvent {
  LanguageChanged(this.locale);

  final Locale locale;
}

class NavigationIndexChanged extends MainEvent {
  NavigationIndexChanged(this.index);

  final int index;
}
