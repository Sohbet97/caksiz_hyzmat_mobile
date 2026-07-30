import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  static const _themeModeKey = 'settings.theme_mode';
  static const _localeKey = 'settings.locale';
  static const _navigationIndexKey = 'settings.navigation_index';
  static const _refreshToken = 'refreshToken';
  static const _authToken = 'authToken';
  static const _registrationStatus = 'registrationStatus';

  Future<ThemeMode> readThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_themeModeKey);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.light,
    );
  }

  Future<void> writeThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, themeMode.name);
  }

  Future<Locale> readLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_localeKey);
    return value != null ? Locale(value) : const Locale('en');
  }

  Future<void> writeLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  Future<int> readNavigationIndex() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_navigationIndexKey) ?? 0;
  }

  Future<void> writeNavigationIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_navigationIndexKey, index);
  }

  Future<String?> readRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshToken);
  }

  Future<void> writeRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshToken, token);
  }

  Future<String?> readAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authToken);
  }

  Future<void> writeAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authToken, token);
  }

  Future<bool> readRegistrationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_registrationStatus) ?? false;
  }

  Future<void> saveRegistrationStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_registrationStatus, value);
  }
}
