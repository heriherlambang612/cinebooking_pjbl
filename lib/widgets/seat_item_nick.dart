import 'package:flutter/material.dart';

class SeatItem_nick extends StatelessWidget {
  final String seatCode;
  final bool isSelected;
  final bool isSold;
  final VoidCallback onTap;

  SeatItem_nick({
    required this.seatCode,
    required this.isSelected,
    required this.isSold,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color seatColor = Colors.grey;
    if (isSold) {
      seatColor = Colors.red;
    } else if (isSelected) {
      seatColor = Colors.blue;
    }

    return GestureDetector(
      onTap: isSold ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12, width: 1),
        ),
        child: Center(
          child: Text(
            seatCode,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
