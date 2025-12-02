import 'package:flutter/material.dart';

class SeatItemNick extends StatelessWidget {
  final String seatIdNick;
  final bool isSoldNick;
  final bool isSelectedNick;
  final Function() onTapNick;

  const SeatItemNick({super.key, required this.seatIdNick, required this.isSoldNick, required this.isSelectedNick, required this.onTapNick});

  @override
  Widget build(BuildContext context) {
    Color seatColorNick;

    if (isSoldNick) {
      // Jika terjual maka logo kursi berwarna merah
      seatColorNick = Colors.red;
    } else if (isSelectedNick) {
      //Jika dipilih maka logo kursi berwarna biru.
      seatColorNick = Colors.blue;
    } else {
      //Jika kursi kosong maka logo kursi berwarna abu-abu.
      seatColorNick = Colors.grey;
    }

    return GestureDetector(
      onTap: isSoldNick ? null : onTapNick, // Nonaktifkan tap jika kursi terjual.
      child: Container(
        margin: const EdgeInsets.all(4),
        width: 35,
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: seatColorNick, borderRadius: BorderRadius.circular(4)),
        child: Text(seatIdNick, style: const TextStyle(fontSize: 12, color: Colors.white)),
      ),
    );
  }
}
