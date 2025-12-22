import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'seat_selection_screen.dart';

class MovieDetailScreen_Husnul extends StatelessWidget {
  final MovieModel_Heri movie;

  MovieDetailScreen_Husnul({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Details')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'movie_${movie.movie_id}',
              child: Image.network(
                movie.poster_url,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    color: Colors.grey[300],
                    child: Center(child: Icon(Icons.movie, size: 100, color: Colors.blue)),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(movie.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                SizedBox(width: 5),
                Text('${movie.rating}'),
                SizedBox(width: 20),
                Icon(Icons.timer, color: Colors.grey, size: 20),
                SizedBox(width: 5),
                Text('${movie.duration} min'),
              ],
            ),
            SizedBox(height: 8),
            Text('Base Price: Rp ${movie.base_price}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(height: 16),
            Text('Description:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Enjoy this amazing movie with your friends and family. Book your seats now!', style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SeatSelectionScreen(movie: movie)));
        },
        label: Text('Book Ticket'),
        icon: Icon(Icons.confirmation_number),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
