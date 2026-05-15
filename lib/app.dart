import 'package:flex_drive/models/car.dart';
import 'package:flex_drive/screens/about_screen.dart';
import 'package:flex_drive/screens/car_details_screen.dart';
import 'package:flex_drive/screens/home_screen.dart';
import 'package:flex_drive/screens/settings_screen.dart';
import 'package:flex_drive/services/settings_repository.dart';
import 'package:flex_drive/theme/app_theme.dart';
import 'package:flex_drive/utils/app_routes.dart';
import 'package:flutter/material.dart';

class FlexDriveApp extends StatefulWidget {
  const FlexDriveApp({
    super.key,
    this.settingsRepository,
    ThemeMode? initialThemeMode,
  }) : initialThemeMode = initialThemeMode ?? ThemeMode.light;

  final SettingsRepository? settingsRepository;
  final ThemeMode initialThemeMode;

  @override
  State<FlexDriveApp> createState() => _FlexDriveAppState();
}

class _FlexDriveAppState extends State<FlexDriveApp> {
  late ThemeMode _themeMode;
  bool _isSavingTheme = false;
  String? _themeSaveError;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  Future<void> _updateThemeMode(ThemeMode mode) async {
    if (_themeMode == mode || _isSavingTheme) {
      return;
    }

    final previousMode = _themeMode;

    setState(() {
      _themeMode = mode;
      _isSavingTheme = true;
      _themeSaveError = null;
    });

    try {
      await widget.settingsRepository?.saveThemeMode(mode);
    } catch (_) {
      setState(() {
        _themeMode = previousMode;
        _themeSaveError = 'Could not save the selected theme.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSavingTheme = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlexDrive',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      scrollBehavior:
          const MaterialScrollBehavior().copyWith(overscroll: false),
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.home:
            return MaterialPageRoute<void>(
              builder: (_) => const HomeScreen(),
              settings: settings,
            );
          case AppRoutes.details:
            final car = settings.arguments;
            if (car is! Car) {
              return MaterialPageRoute<void>(
                builder: (_) => const HomeScreen(),
                settings: settings,
              );
            }
            return MaterialPageRoute<void>(
              builder: (_) => CarDetailsScreen(car: car),
              settings: settings,
            );
          case AppRoutes.settings:
            return MaterialPageRoute<void>(
              builder: (_) => SettingsScreen(
                currentThemeMode: _themeMode,
                isSavingTheme: _isSavingTheme,
                saveError: _themeSaveError,
                onThemeModeChanged: _updateThemeMode,
              ),
              settings: settings,
            );
          case AppRoutes.about:
            return MaterialPageRoute<void>(
              builder: (_) => const AboutScreen(),
              settings: settings,
            );
          default:
            return MaterialPageRoute<void>(
              builder: (_) => const HomeScreen(),
              settings: settings,
            );
        }
      },
    );
  }
}
