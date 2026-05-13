import 'package:flex_drive/models/car.dart';
import 'package:flex_drive/providers/car_list_state.dart';
import 'package:flex_drive/services/car_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final carRepositoryProvider = Provider<CarRepository>((ref) {
  return const CarRepository();
});

final carsProvider = StateNotifierProvider<CarsNotifier, CarListState>((ref) {
  final notifier = CarsNotifier(ref.watch(carRepositoryProvider));
  notifier.loadCars();
  return notifier;
});

class CarsNotifier extends StateNotifier<CarListState> {
  CarsNotifier(this._repository) : super(const CarListState());

  final CarRepository _repository;

  Future<void> loadCars() async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final cars = await _repository.fetchCars();
      state = state.copyWith(
        allCars: cars,
        visibleCars: _filterCars(cars, state.query),
        isLoading: false,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Could not load cars right now.',
      );
    }
  }

  Future<void> reloadCars() async {
    await loadCars();
  }

  void applySearch(String query) {
    final normalizedQuery = query.trim();

    state = state.copyWith(
      query: normalizedQuery,
      visibleCars: _filterCars(state.allCars, normalizedQuery),
      clearError: true,
    );
  }

  void clearSearch() {
    applySearch('');
  }

  List<Car> _filterCars(List<Car> cars, String query) {
    if (query.isEmpty) {
      return cars;
    }

    final normalizedQuery = query.toLowerCase();

    return cars.where((car) {
      final haystack = [
        car.brand,
        car.model,
        car.category,
        car.location,
      ].join(' ').toLowerCase();

      return haystack.contains(normalizedQuery);
    }).toList();
  }
}
