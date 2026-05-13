import 'package:flex_drive/utils/app_routes.dart';
import 'package:flex_drive/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: AppRoutes.home),
      appBar: AppBar(
        title: const Text('FlexDrive'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Carsharing for everyday city trips',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Text(
            'This is the base screen structure. Next we will add real car cards, search, and data.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Planned sections',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  const Text('Available cars'),
                  const SizedBox(height: 8),
                  const Text('Search and filters'),
                  const SizedBox(height: 8),
                  const Text('Quick trip information'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
