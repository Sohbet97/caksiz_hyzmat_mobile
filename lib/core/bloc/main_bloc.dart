import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../storage/settings_storage.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(this._settingsStorage) : super(const MainState()) {
    on<MainStarted>(_onStarted);
    on<ThemeChanged>(_onThemeChanged);
    on<LanguageChanged>(_onLanguageChanged);
    on<NavigationIndexChanged>(_onNavigationIndexChanged);
  }

  final SettingsStorage _settingsStorage;

  Future<void> _onStarted(MainStarted event, Emitter<MainState> emit) async {
    final themeMode = await _settingsStorage.readThemeMode();
    final locale = await _settingsStorage.readLocale();
    final navigationIndex = await _settingsStorage.readNavigationIndex();
    emit(
      state.copyWith(
        themeMode: themeMode,
        locale: locale,
        navigationIndex: navigationIndex,
        isLoading: false,
      ),
    );
  }

  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<MainState> emit,
  ) async {
    await _settingsStorage.writeThemeMode(event.themeMode);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _onLanguageChanged(
    LanguageChanged event,
    Emitter<MainState> emit,
  ) async {
    await _settingsStorage.writeLocale(event.locale);
    emit(state.copyWith(locale: event.locale));
  }

  Future<void> _onNavigationIndexChanged(
    NavigationIndexChanged event,
    Emitter<MainState> emit,
  ) async {
    await _settingsStorage.writeNavigationIndex(event.index);
    emit(state.copyWith(navigationIndex: event.index));
  }
}
