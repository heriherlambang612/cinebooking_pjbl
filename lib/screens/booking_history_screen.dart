import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseService.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text('Booking History')),
      body: StreamBuilder(
        stream: FirebaseService.getUserBookings(user!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading bookings'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final bookings = snapshot.data!.docs;

          if (bookings.isEmpty) {
            return Center(child: Text('No bookings yet'));
          }

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index].data() as Map<String, dynamic>;
              final bookingId = bookings[index].id;

              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(booking['movie_title'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                            child: Text('Rp ${booking['total_price']}', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text('Seats: ${booking['seats'].join(', ')}'),
                      Text('Date: ${booking['booking_date'].toDate().toString()}'),
                      SizedBox(height: 10),
                      Divider(),
                      Center(
                        child: Column(
                          children: [
                            Text('Booking QR Code'),
                            SizedBox(height: 10),
                            QrImageView(data: bookingId, version: QrVersions.auto, size: 150),
                            SizedBox(height: 10),
                            Text('ID: $bookingId', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
