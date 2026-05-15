import 'package:flex_drive/models/car.dart';

class Booking {
  const Booking({
    required this.id,
    required this.carId,
    required this.carName,
    required this.category,
    required this.location,
    required this.pricePerMinute,
    required this.reservedAt,
  });

  final String id;
  final String carId;
  final String carName;
  final String category;
  final String location;
  final int pricePerMinute;
  final DateTime reservedAt;

  String get reservedAtLabel {
    final day = reservedAt.day.toString().padLeft(2, '0');
    final month = reservedAt.month.toString().padLeft(2, '0');
    final year = reservedAt.year.toString();
    final hour = reservedAt.hour.toString().padLeft(2, '0');
    final minute = reservedAt.minute.toString().padLeft(2, '0');

    return '$day.$month.$year · $hour:$minute';
  }

  factory Booking.fromCar(Car car, {DateTime? reservedAt}) {
    final date = reservedAt ?? DateTime.now();

    return Booking(
      id: '${car.id}-${date.toIso8601String()}',
      carId: car.id,
      carName: car.fullName,
      category: car.category,
      location: car.location,
      pricePerMinute: car.pricePerMinute,
      reservedAt: date,
    );
  }
}
