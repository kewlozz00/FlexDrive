import 'package:flex_drive/services/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('settings repository returns light theme by default', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final repository = SettingsRepository(preferences);

    expect(repository.loadThemeMode(), ThemeMode.light);
  });

  test('settings repository saves and loads dark theme', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final repository = SettingsRepository(preferences);

    await repository.saveThemeMode(ThemeMode.dark);

    expect(repository.loadThemeMode(), ThemeMode.dark);
  });
}
