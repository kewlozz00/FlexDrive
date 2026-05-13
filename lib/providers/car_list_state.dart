import 'package:flex_drive/models/car.dart';

class CarListState {
  const CarListState({
    this.allCars = const [],
    this.visibleCars = const [],
    this.query = '',
    this.isLoading = false,
    this.errorMessage,
  });

  final List<Car> allCars;
  final List<Car> visibleCars;
  final String query;
  final bool isLoading;
  final String? errorMessage;

  CarListState copyWith({
    List<Car>? allCars,
    List<Car>? visibleCars,
    String? query,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CarListState(
      allCars: allCars ?? this.allCars,
      visibleCars: visibleCars ?? this.visibleCars,
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
