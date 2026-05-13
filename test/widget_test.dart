import 'package:flex_drive/app.dart';
import 'package:flex_drive/models/car.dart';
import 'package:flex_drive/services/car_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeCarRepository extends CarRepository {
  const FakeCarRepository();

  @override
  Future<List<Car>> fetchCars() async {
    return const [
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
    ];
  }
}

void main() {
  testWidgets('app shows cars loaded from repository', (tester) async {
    await tester.pumpWidget(
      const FlexDriveApp(
        carRepository: FakeCarRepository(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('FlexDrive'), findsOneWidget);
    expect(find.text('Carsharing for everyday city trips'), findsOneWidget);
    expect(find.text('Nearby cars'), findsOneWidget);
    expect(find.text('Tesla Model 3'), findsOneWidget);
    expect(find.text('Loaded from local JSON assets.'), findsOneWidget);
  });
}
