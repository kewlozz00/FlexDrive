import 'package:flex_drive/models/car.dart';
import 'package:flutter/material.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({
    super.key,
    required this.car,
  });

  final Car car;

  @override
  Widget build(BuildContext context) {
    final availabilityColor = car.isAvailable
        ? const Color(0xFF1C6B63)
        : const Color(0xFF8A5E2B);

    return Scaffold(
      appBar: AppBar(
        title: Text(car.fullName),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: AspectRatio(
              aspectRatio: 1.18,
              child: Image.network(
                car.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE6EFEA),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.directions_car_filled_rounded,
                      size: 72,
                      color: Color(0xFF1C6B63),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.fullName,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      car.category,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: const Color(0xFF5A6965),
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: availabilityColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  car.isAvailable ? 'Available' : 'Busy',
                  style: TextStyle(
                    color: availabilityColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: _PriceBlock(
                      title: 'Price',
                      value: '${car.pricePerMinute} EUR/min',
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 52,
                    color: const Color(0xFFE6EAE5),
                  ),
                  Expanded(
                    child: _PriceBlock(
                      title: 'Location',
                      value: car.location,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DetailCard(
                icon: Icons.battery_charging_full_rounded,
                title: 'Battery',
                value: '${car.batteryPercent}%',
              ),
              _DetailCard(
                icon: Icons.route_rounded,
                title: 'Range',
                value: '${car.rangeKm} km',
              ),
              _DetailCard(
                icon: Icons.event_seat_rounded,
                title: 'Seats',
                value: '${car.seats}',
              ),
              _DetailCard(
                icon: Icons.settings_rounded,
                title: 'Gearbox',
                value: car.transmission,
              ),
              _DetailCard(
                icon: Icons.place_outlined,
                title: 'Distance',
                value: '${car.distanceKm.toStringAsFixed(1)} km',
              ),
            ],
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About this car',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    car.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF5A6965),
                          height: 1.45,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.lock_open_rounded),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Reserve this car'),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceBlock extends StatelessWidget {
  const _PriceBlock({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF5A6965),
              ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 156,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: const Color(0xFF1C6B63),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF5A6965),
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
