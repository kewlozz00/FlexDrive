import 'package:flex_drive/models/car.dart';
import 'package:flutter/material.dart';

class CarPreviewCard extends StatelessWidget {
  const CarPreviewCard({
    super.key,
    required this.car,
    required this.onTap,
  });

  final Car car;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accentColor = _accentColor;
    final statusColor = car.isAvailable
        ? const Color(0xFF1C6B63)
        : const Color(0xFF8A5E2B);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 78,
                  height: 78,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    _icon,
                    size: 34,
                    color: accentColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car.fullName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        car.category,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF60716C),
                            ),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _MetaChip(
                            icon: Icons.place_outlined,
                            label: car.location,
                          ),
                          _MetaChip(
                            icon: Icons.schedule_rounded,
                            label: '${car.distanceKm.toStringAsFixed(1)} km away',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        car.isAvailable ? 'Available' : 'Busy',
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      '${car.pricePerMinute} EUR/min',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 6),
                    const Icon(Icons.arrow_forward_rounded),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color get _accentColor {
    switch (car.brand) {
      case 'Tesla':
        return const Color(0xFF1C6B63);
      case 'Mini':
        return const Color(0xFFB98145);
      case 'BMW':
        return const Color(0xFF587C9B);
      case 'Volkswagen':
        return const Color(0xFF5A7D58);
      case 'Hyundai':
        return const Color(0xFF8A5E2B);
      default:
        return const Color(0xFF6A7280);
    }
  }

  IconData get _icon {
    if (car.category.toLowerCase().contains('sedan')) {
      return Icons.bolt_rounded;
    }

    if (car.category.toLowerCase().contains('crossover')) {
      return Icons.directions_car_filled_rounded;
    }

    if (car.category.toLowerCase().contains('hatchback')) {
      return Icons.route_rounded;
    }

    if (car.category.toLowerCase().contains('micro')) {
      return Icons.electric_car_rounded;
    }

    return Icons.directions_car_rounded;
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4EF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF5A6965),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF5A6965),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
