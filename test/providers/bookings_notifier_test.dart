import 'package:flex_drive/models/car.dart';
import 'package:flex_drive/providers/bookings_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

const _testCar = Car(
  id: 'tesla-model-3',
  brand: 'Tesla',
  model: 'Model 3',
  category: 'Electric sedan',
  location: 'Campus parking',
  pricePerMinute: 4,
  distanceKm: 0.4,
  batteryPercent: 84,
  rangeKm: 412,
  seats: 5,
  transmission: 'Automatic',
  isAvailable: true,
  imageUrl: 'https://example.com/tesla.jpg',
  description: 'Test description',
);

void main() {
  test('bookings notifier adds and cancels a booking', () {
    final notifier = BookingsNotifier();
    final didAdd = notifier.addBooking(
      _testCar,
      reservedAt: DateTime(2026, 5, 15, 18, 30),
    );

    expect(didAdd, isTrue);
    expect(notifier.state.length, 1);
    expect(notifier.state.first.carId, _testCar.id);

    notifier.cancelBooking(notifier.state.first.id);

    expect(notifier.state, isEmpty);
  });

  test('bookings notifier prevents duplicate bookings for one car', () {
    final notifier = BookingsNotifier();

    final firstAdd = notifier.addBooking(_testCar);
    final secondAdd = notifier.addBooking(_testCar);

    expect(firstAdd, isTrue);
    expect(secondAdd, isFalse);
    expect(notifier.state.length, 1);
  });
}
