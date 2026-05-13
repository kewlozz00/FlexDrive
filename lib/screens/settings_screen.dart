import 'package:flex_drive/utils/app_routes.dart';
import 'package:flex_drive/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.currentThemeMode,
    required this.isSavingTheme,
    required this.saveError,
    required this.onThemeModeChanged,
  });

  final ThemeMode currentThemeMode;
  final bool isSavingTheme;
  final String? saveError;
  final Future<void> Function(ThemeMode mode) onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: AppRoutes.settings),
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appearance',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Choose how FlexDrive looks and keep your preference saved on this device.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF5A6965),
                        ),
                  ),
                  const SizedBox(height: 20),
                  SegmentedButton<ThemeMode>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment<ThemeMode>(
                        value: ThemeMode.light,
                        icon: Icon(Icons.light_mode_rounded),
                        label: Text('Light'),
                      ),
                      ButtonSegment<ThemeMode>(
                        value: ThemeMode.dark,
                        icon: Icon(Icons.dark_mode_rounded),
                        label: Text('Dark'),
                      ),
                    ],
                    selected: {currentThemeMode},
                    onSelectionChanged: isSavingTheme
                        ? null
                        : (selection) {
                            onThemeModeChanged(selection.first);
                          },
                  ),
                  const SizedBox(height: 18),
                  _ThemePreview(
                    currentThemeMode: currentThemeMode,
                  ),
                  if (isSavingTheme) ...[
                    const SizedBox(height: 18),
                    const LinearProgressIndicator(),
                  ],
                  if (saveError != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      saveError!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current mode',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    currentThemeMode == ThemeMode.dark
                        ? 'Dark mode is active.'
                        : 'Light mode is active.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF5A6965),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemePreview extends StatelessWidget {
  const _ThemePreview({
    required this.currentThemeMode,
  });

  final ThemeMode currentThemeMode;

  @override
  Widget build(BuildContext context) {
    final isDark = currentThemeMode == ThemeMode.dark;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF101513) : const Color(0xFFF1F3EC),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1A2320)
                        : const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 64,
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF18201D)
                  : const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(22),
            ),
          ),
        ],
      ),
    );
  }
}
