import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie_model.dart';
import '../providers/booking_provider.dart';
import '../widgets/seat_item_nick.dart';

class SeatSelectionNick extends StatefulWidget {
  final MovieModel_Heri movie;

  SeatSelectionNick({required this.movie});

  @override
  _SeatSelectionNick createState() => _SeatSelectionNick();
}

class _SeatSelectionNick extends State<SeatSelectionNick> {
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

              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8, crossAxisSpacing: 10, mainAxisSpacing: 10),
                  itemCount: 48, // 6 rows x 8 columns
                  itemBuilder: (context, index) {
                    int row = index ~/ 8;
                    int col = index % 8;
                    String seatCode = '${String.fromCharCode(65 + row)}${col + 1}';

                    bool isSold = ['A1', 'A2', 'B5'].contains(seatCode);

                    return SeatItemNick(
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
                          'Rp ${provider.calculateTotal(widget.movie.base_price, widget.movie.title)}',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        SizedBox(height: 4),
                        Text('${provider.selectedSeats.length} seat(s) selected', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: provider.selectedSeats.isEmpty
                          ? null
                          : () {
                              provider.checkout(widget.movie);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking Successful!'), duration: Duration(seconds: 2)));
                              Navigator.pop(context); // Kembali ke detail
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
