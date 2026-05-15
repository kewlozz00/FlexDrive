import 'package:flex_drive/models/car.dart';
import 'package:flex_drive/providers/car_list_notifier.dart';
import 'package:flex_drive/screens/home_screen.dart';
import 'package:flex_drive/services/car_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeCarRepository extends CarRepository {
  const FakeCarRepository(this._cars);

  final List<Car> _cars;

  @override
  Future<List<Car>> fetchCars() async {
    return _cars;
  }
}

const _cars = [
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

Widget _buildTestApp() {
  return ProviderScope(
    overrides: [
      carRepositoryProvider.overrideWithValue(
        const FakeCarRepository(_cars),
      ),
    ],
    child: const MaterialApp(
      home: HomeScreen(),
    ),
  );
}

void _setLargeDisplay(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 1400);
  tester.view.devicePixelRatio = 1;

  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('home screen shows validation error for one character search',
      (tester) async {
    _setLargeDisplay(tester);
    await tester.pumpWidget(_buildTestApp());
    await tester.pump();

    await tester.enterText(find.byType(TextFormField), 'a');
    await tester.pump();
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Search'));
    await tester.tap(find.widgetWithText(FilledButton, 'Search'));
    await tester.pump();

    expect(find.text('Enter at least 2 characters'), findsOneWidget);
    expect(find.text('Results for "a".'), findsNothing);
  });

  testWidgets('home screen filters cars by search query', (tester) async {
    _setLargeDisplay(tester);
    await tester.pumpWidget(_buildTestApp());
    await tester.pump();

    await tester.enterText(find.byType(TextFormField), 'mini');
    await tester.pump();
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Search'));
    await tester.tap(find.widgetWithText(FilledButton, 'Search'));
    await tester.pump();

    expect(find.text('Mini Cooper SE'), findsOneWidget);
    expect(find.text('Results for "mini".'), findsOneWidget);
    expect(find.text('Tesla Model 3'), findsNothing);
  });
}
