import 'package:flutter/material.dart';
import '../models/movie_model_all.dart';
import 'seat_selection_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieModel_all movie;

  MovieDetailScreen({required this.movie});

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
              ),
            ),
            SizedBox(height: 16),
            Text(
              movie.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Rating: ${movie.rating} ⭐'),
            Text('Duration: ${movie.duration} minutes'),
            Text('Base Price: Rp ${movie.base_price}'),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeatSelectionScreen(movie: movie),
            ),
          );
        },
        label: Text('Book Ticket'),
        icon: Icon(Icons.confirmation_number),
      ),
    );
  }
}