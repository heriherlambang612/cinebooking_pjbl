import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie_model_all.dart';
import '../providers/booking_provider.dart';
import '../widgets/seat_item_nick.dart';

class SeatSelectionScreen extends StatelessWidget {
  final MovieModel_all movie;

  SeatSelectionScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Seats')),
      body: Consumer<BookingProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text('SCREEN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [_buildLegendItem(Colors.grey, 'Available'), _buildLegendItem(Colors.blue, 'Selected'), _buildLegendItem(Colors.red, 'Sold')],
                ),
              ),

              SizedBox(height: 20),

              // Grid Kursi
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8, crossAxisSpacing: 10, mainAxisSpacing: 10),
                  itemCount: 48,
                  itemBuilder: (context, index) {
                    int row = index ~/ 8;
                    int col = index % 8;
                    String seatCode = '${String.fromCharCode(65 + row)}${col + 1}';

                    bool isSold = ['A1', 'A2', 'B5'].contains(seatCode); // Contoh kursi yang sudah terjual

                    return SeatItem_nick(
                      seatCode: seatCode,
                      isSelected: provider.selectedSeats.contains(seatCode),
                      isSold: isSold,
                      onTap: () {
                        if (!isSold) {
                          provider.toggleSeat(seatCode);
                        }
                      },
                    );
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Price', style: TextStyle(fontSize: 16)),
                        Text(
                          'Rp ${provider.calculateTotal(movie.base_price, movie.title)}',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        provider.checkout(movie);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking Successful!')));
                        Navigator.popUntil(context, ModalRoute.withName('/home'));
                      },
                      child: Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(width: 20, height: 20, color: color),
        SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
