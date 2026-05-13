import 'package:flex_drive/models/car.dart';
import 'package:flex_drive/screens/about_screen.dart';
import 'package:flex_drive/screens/car_details_screen.dart';
import 'package:flex_drive/screens/home_screen.dart';
import 'package:flex_drive/screens/settings_screen.dart';
import 'package:flex_drive/services/car_repository.dart';
import 'package:flex_drive/utils/app_routes.dart';
import 'package:flutter/material.dart';

class FlexDriveApp extends StatelessWidget {
  const FlexDriveApp({
    super.key,
    CarRepository? carRepository,
  }) : carRepository = carRepository ?? const CarRepository();

  final CarRepository carRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlexDrive',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1C6B63),
          surface: const Color(0xFFF5F6F1),
        ),
        scaffoldBackgroundColor: const Color(0xFFF1F3EC),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Color(0xFFF1F3EC),
          foregroundColor: Color(0xFF12201D),
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.home:
            return MaterialPageRoute<void>(
              builder: (_) => HomeScreen(carRepository: carRepository),
              settings: settings,
            );
          case AppRoutes.details:
            final car = settings.arguments;
            if (car is! Car) {
              return MaterialPageRoute<void>(
                builder: (_) => HomeScreen(carRepository: carRepository),
                settings: settings,
              );
            }
            return MaterialPageRoute<void>(
              builder: (_) => CarDetailsScreen(car: car),
              settings: settings,
            );
          case AppRoutes.settings:
            return MaterialPageRoute<void>(
              builder: (_) => const SettingsScreen(),
              settings: settings,
            );
          case AppRoutes.about:
            return MaterialPageRoute<void>(
              builder: (_) => const AboutScreen(),
              settings: settings,
            );
          default:
            return MaterialPageRoute<void>(
              builder: (_) => HomeScreen(carRepository: carRepository),
              settings: settings,
            );
        }
      },
    );
  }
}
