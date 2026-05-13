import 'package:flex_drive/models/car.dart';
import 'package:flex_drive/providers/car_list_notifier.dart';
import 'package:flex_drive/services/car_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeCarRepository extends CarRepository {
  const FakeCarRepository(this._cars);

  final List<Car> _cars;

  @override
  Future<List<Car>> fetchCars() async {
    return _cars;
  }
}

const _testCars = [
  Car(
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
  ),
  Car(
    id: 'mini-cooper-se',
    brand: 'Mini',
    model: 'Cooper SE',
    category: 'Compact city car',
    location: 'Old town',
    pricePerMinute: 3,
    distanceKm: 1.1,
    batteryPercent: 67,
    rangeKm: 210,
    seats: 4,
    transmission: 'Automatic',
    isAvailable: true,
    imageUrl: 'https://example.com/mini.jpg',
    description: 'Test description',
  ),
];

void main() {
  test('cars notifier loads cars and filters search results', () async {
    final notifier = CarsNotifier(const FakeCarRepository(_testCars));

    await notifier.loadCars();

    expect(notifier.state.visibleCars.length, 2);

    notifier.applySearch('tesla');

    expect(notifier.state.visibleCars.length, 1);
    expect(notifier.state.visibleCars.first.brand, 'Tesla');
  });
}
