import 'dart:convert';

import 'package:flex_drive/models/car.dart';
import 'package:flutter/services.dart';

typedef CarsLoader = Future<String> Function();

class CarRepository {
  const CarRepository({
    this.loader,
  });

  final CarsLoader? loader;

  Future<List<Car>> fetchCars() async {
    final rawJson = await (loader ?? _defaultLoader).call();
    final decoded = jsonDecode(rawJson) as List<dynamic>;

    return decoded
        .map((item) => Car.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static Future<String> _defaultLoader() {
    return rootBundle.loadString('assets/data/cars.json');
  }
}
