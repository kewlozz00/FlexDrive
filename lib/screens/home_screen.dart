import 'package:flex_drive/utils/app_routes.dart';
import 'package:flex_drive/widgets/app_drawer.dart';
import 'package:flex_drive/widgets/car_preview_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _cars = [
    (
      title: 'Tesla Model 3',
      subtitle: 'Electric sedan',
      location: 'Campus parking',
      price: '4 €/min',
      distance: '0.4 km away',
      accent: Color(0xFF1C6B63),
      icon: Icons.bolt_rounded,
    ),
    (
      title: 'Mini Cooper SE',
      subtitle: 'Compact city car',
      location: 'Old town',
      price: '3 €/min',
      distance: '1.1 km away',
      accent: Color(0xFFB98145),
      icon: Icons.directions_car_filled_rounded,
    ),
    (
      title: 'BMW i3',
      subtitle: 'Small urban electric',
      location: 'Student village',
      price: '3 €/min',
      distance: '0.8 km away',
      accent: Color(0xFF587C9B),
      icon: Icons.electric_car_rounded,
    ),
    (
      title: 'Volkswagen ID.3',
      subtitle: 'Daily hatchback',
      location: 'Central station',
      price: '2 €/min',
      distance: '2.0 km away',
      accent: Color(0xFF5A7D58),
      icon: Icons.route_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: AppRoutes.home),
      appBar: AppBar(
        title: const Text('FlexDrive'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF1C6B63),
                  Color(0xFF2B8A7F),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    '8 cars available now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Carsharing for everyday city trips',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Choose a nearby car, unlock it in seconds and drive across the city with a simple student-friendly flow.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        height: 1.45,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6EFEA),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.map_outlined,
                      color: Color(0xFF1C6B63),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nearby zone',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Campus and city center are the fastest pickup areas right now.',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xFF50605C),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Nearby cars',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'A first static version of the list before connecting JSON data.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF5A6965),
                ),
          ),
          const SizedBox(height: 16),
          ..._cars.map(
            (car) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: CarPreviewCard(
                title: car.title,
                subtitle: car.subtitle,
                location: car.location,
                price: car.price,
                distance: car.distance,
                accent: car.accent,
                icon: car.icon,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.details);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
