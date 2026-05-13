import 'package:flex_drive/models/car.dart';
import 'package:flex_drive/screens/car_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const testCar = Car(
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
  testWidgets('car details screen renders car information', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CarDetailsScreen(car: testCar),
      ),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('About this car'),
      300,
    );
    await tester.pumpAndSettle();

    expect(find.text('Tesla Model 3'), findsOneWidget);
    expect(find.text('About this car'), findsOneWidget);
    expect(find.text('84%'), findsOneWidget);
    expect(find.text('Reserve this car'), findsOneWidget);
  });
}
