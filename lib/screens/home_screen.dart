import 'package:flutter/material.dart';
import '../models/movie_model_all.dart';
import '../services/firebase_service.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CineBooking'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseService.getMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error'));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final movies = snapshot.data!.docs.map((doc) {
            return MovieModel_all.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.7),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movies[index])));
                },
                child: MovieCard(movie: movies[index]),
              );
            },
          );
        },
      ),
    );
  }
}
