import 'package:flex_drive/models/car.dart';
import 'package:flex_drive/services/car_repository.dart';
import 'package:flex_drive/utils/app_routes.dart';
import 'package:flex_drive/utils/validators.dart';
import 'package:flex_drive/widgets/app_drawer.dart';
import 'package:flex_drive/widgets/car_preview_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    CarRepository? carRepository,
  }) : carRepository = carRepository ?? const CarRepository();

  final CarRepository carRepository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchFormKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  late Future<List<Car>> _carsFuture;
  String _activeQuery = '';

  @override
  void initState() {
    super.initState();
    _carsFuture = widget.carRepository.fetchCars();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reloadCars() {
    setState(() {
      _carsFuture = widget.carRepository.fetchCars();
    });
  }

  void _applySearch() {
    final isValid = _searchFormKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() {
      _activeQuery = _searchController.text.trim();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _activeQuery = '';
    });
    _searchFormKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: AppRoutes.home),
      appBar: AppBar(
        title: const Text('FlexDrive'),
      ),
      body: FutureBuilder<List<Car>>(
        future: _carsFuture,
        builder: (context, snapshot) {
          final cars = snapshot.data ?? const <Car>[];
          final filteredCars = _filterCars(cars, _activeQuery);

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: [
              _HeroSection(label: _heroLabel(snapshot, filteredCars)),
              const SizedBox(height: 20),
              const _ZoneCard(),
              const SizedBox(height: 20),
              _SearchCard(
                formKey: _searchFormKey,
                controller: _searchController,
                onSearch: _applySearch,
                onClear: _clearSearch,
              ),
              const SizedBox(height: 24),
              Text(
                'Nearby cars',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                _activeQuery.isEmpty
                    ? 'Loaded from local JSON assets.'
                    : 'Results for "$_activeQuery".',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF5A6965),
                    ),
              ),
              const SizedBox(height: 16),
              ..._buildCarsSection(context, snapshot, filteredCars),
            ],
          );
        },
      ),
    );
  }

  String _heroLabel(AsyncSnapshot<List<Car>> snapshot, List<Car> cars) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return 'Loading cars...';
    }

    if (snapshot.hasError) {
      return 'Cars unavailable';
    }

    final availableCars = cars.where((car) => car.isAvailable).length;
    return '$availableCars cars available now';
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

  List<Widget> _buildCarsSection(
    BuildContext context,
    AsyncSnapshot<List<Car>> snapshot,
    List<Car> cars,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 28),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ];
    }

    if (snapshot.hasError) {
      return [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Could not load cars right now.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Please try again.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _reloadCars,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    if (cars.isEmpty) {
      final message = _activeQuery.isEmpty
          ? 'No cars are available in the current list.'
          : 'No cars match "$_activeQuery".';

      return [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (_activeQuery.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: _clearSearch,
                    child: const Text('Clear search'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ];
    }

    return cars
        .map(
          (car) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: CarPreviewCard(
              car: car,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.details,
                  arguments: car,
                );
              },
            ),
          ),
        )
        .toList();
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1C6B63),
            Color(0xFF2B8A7F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Carsharing for everyday city trips',
            style: TextStyle(
              color: Colors.white,
              fontSize: 29,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Choose a nearby car, unlock it in seconds and drive across the city with a simple student-friendly flow.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.45,
                ),
          ),
        ],
      ),
    );
  }
}

class _ZoneCard extends StatelessWidget {
  const _ZoneCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFE6EFEA),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.map_outlined,
                color: Color(0xFF1C6B63),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nearby zone',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Campus and city center are the fastest pickup areas right now.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF50605C),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchCard extends StatelessWidget {
  const _SearchCard({
    required this.formKey,
    required this.controller,
    required this.onSearch,
    required this.onClear,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search cars',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Search by brand, model, category or location.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF5A6965),
                    ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.search,
                validator: validateSearchQuery,
                onFieldSubmitted: (_) => onSearch(),
                decoration: InputDecoration(
                  hintText: 'Try Tesla, Mini or campus',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: controller.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: onClear,
                          icon: const Icon(Icons.close_rounded),
                        ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: onSearch,
                      child: const Text('Search'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onClear,
                      child: const Text('Clear'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
