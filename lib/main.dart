import 'package:flex_drive/app.dart';
import 'package:flex_drive/services/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final settingsRepository = SettingsRepository(preferences);

  runApp(
    FlexDriveApp(
      settingsRepository: settingsRepository,
      initialThemeMode: settingsRepository.loadThemeMode(),
    ),
  );
}
