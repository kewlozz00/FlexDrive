import 'package:flex_drive/models/car.dart';
import 'package:flutter_test/flutter_test.dart';

const _carJson = {
  'id': 'tesla-model-3',
  'brand': 'Tesla',
  'model': 'Model 3',
  'category': 'Electric sedan',
  'location': 'Campus parking',
  'pricePerMinute': 4,
  'distanceKm': 0.4,
  'batteryPercent': 84,
  'rangeKm': 412,
  'seats': 5,
  'transmission': 'Automatic',
  'isAvailable': true,
  'imageUrl': 'https://example.com/tesla.jpg',
  'description': 'Test description',
};

void main() {
  test('car model parses json correctly', () {
    final car = Car.fromJson(_carJson);

    expect(car.id, 'tesla-model-3');
    expect(car.fullName, 'Tesla Model 3');
    expect(car.distanceKm, 0.4);
    expect(car.isAvailable, isTrue);
  });

  test('car model converts back to json', () {
    const car = Car(
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

    expect(car.toJson(), _carJson);
  });
}
