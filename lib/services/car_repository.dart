import 'dart:convert';

import 'package:flex_drive/models/car.dart';
import 'package:flutter/services.dart';

class CarRepository {
  const CarRepository();

  Future<List<Car>> fetchCars() async {
    final rawJson = await rootBundle.loadString('assets/data/cars.json');
    final decoded = jsonDecode(rawJson) as List<dynamic>;

    return decoded
        .map((item) => Car.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
