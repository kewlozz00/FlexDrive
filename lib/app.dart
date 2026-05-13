import 'package:flex_drive/screens/about_screen.dart';
import 'package:flex_drive/screens/car_details_screen.dart';
import 'package:flex_drive/screens/home_screen.dart';
import 'package:flex_drive/screens/settings_screen.dart';
import 'package:flex_drive/utils/app_routes.dart';
import 'package:flutter/material.dart';

class FlexDriveApp extends StatelessWidget {
  const FlexDriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlexDrive',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1C6B63)),
      ),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.details: (_) => const CarDetailsScreen(),
        AppRoutes.settings: (_) => const SettingsScreen(),
        AppRoutes.about: (_) => const AboutScreen(),
      },
    );
  }
}
