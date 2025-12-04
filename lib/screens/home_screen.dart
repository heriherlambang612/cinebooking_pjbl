import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie_model.dart';
import '../services/firebase_service.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class HomeScreen_Husnul extends StatelessWidget {
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
        stream: FirebaseService_Heri.getMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading movies'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final movies = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return MovieModel_Heri.fromMap(data);
          }).toList();

          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailScreen_Husnul(movie: movies[index]),
                    ),
                  );
                },
                child: MovieCard_Husnul(movie: movies[index]),
              );
            },
          );
        },
      ),
    );
  }
}
