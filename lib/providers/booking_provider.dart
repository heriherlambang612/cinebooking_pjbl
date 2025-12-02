import 'package:flutter/material.dart';
import '../models/movie_model_all.dart';
import '../services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingProvider with ChangeNotifier {
  List<String> selectedSeats = [];

  void toggleSeat(String seatCode) {
    if (selectedSeats.contains(seatCode)) {
      selectedSeats.remove(seatCode);
    } else {
      selectedSeats.add(seatCode);
    }
    notifyListeners();
  }

  void clearSeats() {
    selectedSeats.clear();
    notifyListeners();
  }

  int _calculateTax(int basePrice, String title) {
    if (title.length > 10) {
      return 2500;
    }
    return 0;
  }

  int _calculateSeatDiscount(int basePrice, String seatCode) {

    String numberStr = seatCode.replaceAll(RegExp(r'[^0-9]'), '');
    if (numberStr.isEmpty) return 0;
    
    int seatNumber = int.parse(numberStr);
    
    if (seatNumber % 2 == 0) {
      return (basePrice * 0.1).round();
    }
    
    return 0;
  }

  int calculateTotal(int basePrice, String title) {
    if (selectedSeats.isEmpty) return 0;

    int total = 0;
    int tax = _calculateTax(basePrice, title);

    for (String seat in selectedSeats) {
      int seatPrice = basePrice;
      seatPrice -= _calculateSeatDiscount(basePrice, seat);
      total += seatPrice;
    }

    total += (tax * selectedSeats.length);
    return total;
  }

  Future<void> checkout(MovieModel_all movie) async {
    if (selectedSeats.isEmpty) return;

    final user = FirebaseService.currentUser;
    if (user == null) return;

    int totalPrice = calculateTotal(movie.base_price, movie.title);

    Map<String, dynamic> bookingData = {
      'user_id': user.uid,
      'movie_title': movie.title,
      'seats': selectedSeats,
      'total_price': totalPrice,
      'booking_date': DateTime.now(),
    };

    await FirebaseService.addBooking(bookingData);
    clearSeats();
  }
}