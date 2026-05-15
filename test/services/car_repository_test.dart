import 'package:flex_drive/services/car_repository.dart';
import 'package:flutter_test/flutter_test.dart';

const _carsJson = '''
[
  {
    "id": "tesla-model-3",
    "brand": "Tesla",
    "model": "Model 3",
    "category": "Electric sedan",
    "location": "Campus parking",
    "pricePerMinute": 4,
    "distanceKm": 0.4,
    "batteryPercent": 84,
    "rangeKm": 412,
    "seats": 5,
    "transmission": "Automatic",
    "isAvailable": true,
    "imageUrl": "https://example.com/tesla.jpg",
    "description": "Test description"
  },
  {
    "id": "mini-cooper-se",
    "brand": "Mini",
    "model": "Cooper SE",
    "category": "Compact city car",
    "location": "Old town",
    "pricePerMinute": 3,
    "distanceKm": 1.1,
    "batteryPercent": 67,
    "rangeKm": 210,
    "seats": 4,
    "transmission": "Automatic",
    "isAvailable": true,
    "imageUrl": "https://example.com/mini.jpg",
    "description": "Test description"
  }
]
''';

void main() {
  test('car repository loads and parses cars from json', () async {
    final repository = CarRepository(
      loader: () async => _carsJson,
    );

    final cars = await repository.fetchCars();

    expect(cars.length, 2);
    expect(cars.first.fullName, 'Tesla Model 3');
    expect(cars.last.location, 'Old town');
  });
}
