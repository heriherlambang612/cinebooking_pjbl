import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../services/firebase_service.dart';

class BookingHistoryScreen_Leni extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseService_Heri.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text('Booking History')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseService_Heri.getUserBookings(user!.uid),
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
              final bookingDoc = bookings[index];
              final booking = bookingDoc.data()! as Map<String, dynamic>;
              final bookingId = bookingDoc.id;

              dynamic bookingDate = booking['booking_date'];
              String dateString = '';

              if (bookingDate is Timestamp) {
                dateString = bookingDate.toDate().toString();
              } else if (bookingDate is DateTime) {
                dateString = bookingDate.toString();
              } else {
                dateString = 'Unknown date';
              }

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
                          Expanded(
                            child: Text(
                              booking['movie_title'] ?? 'No Title',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Rp ${booking['total_price'] ?? 0}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text('Seats: ${(booking['seats'] as List).join(', ')}'),
                      Text('Date: $dateString'),
                      SizedBox(height: 10),
                      Divider(),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Booking QR Code',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            QrImageView(
                              data: bookingId,
                              version: QrVersions.auto,
                              size: 150,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'ID: ${bookingId.substring(0, 8)}...',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
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
