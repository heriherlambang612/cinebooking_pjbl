import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class MovieCard_Husnul extends StatelessWidget {
  final MovieModel_Heri movie;

  MovieCard_Husnul({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: 'movie_${movie.movie_id}',
              child: Image.network(
                movie.poster_url,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('Rp ${movie.base_price}'),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(' ${movie.rating}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
