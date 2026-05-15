import 'package:flex_drive/models/booking.dart';
import 'package:flex_drive/models/car.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingsProvider = StateNotifierProvider<BookingsNotifier, List<Booking>>(
  (ref) {
    return BookingsNotifier();
  },
);

class BookingsNotifier extends StateNotifier<List<Booking>> {
  BookingsNotifier([List<Booking>? initialBookings])
    : super(initialBookings ?? const []);

  bool addBooking(Car car, {DateTime? reservedAt}) {
    if (hasBookingForCar(car.id)) {
      return false;
    }

    final booking = Booking.fromCar(car, reservedAt: reservedAt);

    state = [booking, ...state];
    return true;
  }

  bool hasBookingForCar(String carId) {
    return state.any((booking) => booking.carId == carId);
  }

  void cancelBooking(String bookingId) {
    state = state.where((booking) => booking.id != bookingId).toList();
  }
}
