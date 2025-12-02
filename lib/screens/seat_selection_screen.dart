import 'package:flutter/material.dart';
import '../widgets/seat_item_nick.dart';
import '../models/movie_model_all.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';

class SeatMatrixNick extends StatefulWidget {
  final List<String> soldSeats;
  final String movieTitle;

  const SeatMatrixNick({super.key, required this.soldSeats, required this.movieTitle});

  @override
  State<SeatMatrixNick> createState() => _SeatMatrixNickState();
}

class _SeatMatrixNickState extends State<SeatMatrixNick> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Kursi - ${widget.movieTitle}')),
      body: Column(
        children: [
          // Screen indicator
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 30),
            child: Text(
              'LAYAR',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),

          // Seat grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8, mainAxisSpacing: 4, crossAxisSpacing: 4),
              itemCount: 48,
              itemBuilder: (context, index) {
                int row = index ~/ 8;
                int col = index % 8;
                String seatId = '${String.fromCharCode(65 + row)}${col + 1}';
                bool isSold = widget.soldSeats.contains(seatId);
                bool isSelected = selectedSeats.contains(seatId);

                return SeatItemNick(
                  seatIdNick: seatId,
                  isSoldNick: isSold,
                  isSelectedNick: isSelected,
                  onTapNick: () {
                    if (!isSold) {
                      setState(() {
                        if (isSelected) {
                          selectedSeats.remove(seatId);
                        } else {
                          selectedSeats.add(seatId);
                        }
                      });
                    }
                  },
                );
              },
            ),
          ),

          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_colorBox(Colors.grey, 'Tersedia'), SizedBox(width: 15), _colorBox(Colors.blue, 'Dipilih'), SizedBox(width: 15), _colorBox(Colors.red, 'Terjual')],
            ),
          ),

          // Selected seats
          if (selectedSeats.isNotEmpty)
            Container(
              padding: EdgeInsets.all(16),
              child: Text('Kursi dipilih: ${selectedSeats.join(', ')}', style: TextStyle(fontWeight: FontWeight.bold)),
            ),

          // Tombol Konfirmasi
          Container(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: selectedSeats.isEmpty
                  ? null
                  : () {
                      // Simpan ke provider
                      final provider = Provider.of<BookingProvider>(context, listen: false);
                      provider.selectedSeats = selectedSeats;

                      // Kembali dengan data
                      Navigator.pop(context, selectedSeats);
                    },
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.blue),
              child: Text('KONFIRMASI (${selectedSeats.length} kursi)', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorBox(Color color, String label) {
    return Row(
      children: [
        Container(width: 15, height: 15, color: color, margin: EdgeInsets.only(right: 5)),
        Text(label),
      ],
    );
  }
}
