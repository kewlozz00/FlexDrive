class Car {
  const Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.category,
    required this.location,
    required this.pricePerMinute,
    required this.distanceKm,
    required this.batteryPercent,
    required this.rangeKm,
    required this.seats,
    required this.transmission,
    required this.isAvailable,
    required this.imageUrl,
    required this.description,
  });

  final String id;
  final String brand;
  final String model;
  final String category;
  final String location;
  final int pricePerMinute;
  final double distanceKm;
  final int batteryPercent;
  final int rangeKm;
  final int seats;
  final String transmission;
  final bool isAvailable;
  final String imageUrl;
  final String description;

  String get fullName => '$brand $model';

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      category: json['category'] as String,
      location: json['location'] as String,
      pricePerMinute: json['pricePerMinute'] as int,
      distanceKm: (json['distanceKm'] as num).toDouble(),
      batteryPercent: json['batteryPercent'] as int,
      rangeKm: json['rangeKm'] as int,
      seats: json['seats'] as int,
      transmission: json['transmission'] as String,
      isAvailable: json['isAvailable'] as bool,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'category': category,
      'location': location,
      'pricePerMinute': pricePerMinute,
      'distanceKm': distanceKm,
      'batteryPercent': batteryPercent,
      'rangeKm': rangeKm,
      'seats': seats,
      'transmission': transmission,
      'isAvailable': isAvailable,
      'imageUrl': imageUrl,
      'description': description,
    };
  }
}
