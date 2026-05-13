import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  const SettingsRepository(this._preferences);

  static const _themeModeKey = 'theme_mode';
  final SharedPreferences _preferences;

  ThemeMode loadThemeMode() {
    final savedValue = _preferences.getString(_themeModeKey);

    switch (savedValue) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
      default:
        return ThemeMode.light;
    }
  }

  Future<void> saveThemeMode(ThemeMode mode) {
    final value = mode == ThemeMode.dark ? 'dark' : 'light';
    return _preferences.setString(_themeModeKey, value);
  }
}
