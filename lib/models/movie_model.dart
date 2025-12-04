import 'package:cloud_firestore/cloud_firestore.dart';

class MovieModel_Heri {
  String movie_id;
  String title;
  String poster_url;
  int base_price;
  double rating;
  int duration;

  MovieModel_Heri({
    required this.movie_id,
    required this.title,
    required this.poster_url,
    required this.base_price,
    required this.rating,
    required this.duration,
  });

  factory MovieModel_Heri.fromMap(Map<String, dynamic> map) {
    return MovieModel_Heri(
      movie_id: map['movie_id'] ?? map['id'] ?? '',
      title: map['title'] ?? '',
      poster_url:
          map['poster_url'] ??
          map['poster'] ??
          'https://via.placeholder.com/150',
      base_price: map['base_price'] ?? 50000,
      rating: (map['rating'] ?? 4.0).toDouble(),
      duration: map['duration'] ?? 120,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'movie_id': movie_id,
      'title': title,
      'poster_url': poster_url,
      'base_price': base_price,
      'rating': rating,
      'duration': duration,
    };
  }
}

class UserModel_Heri {
  String uid;
  String email;
  String username;
  int balance;
  Timestamp created_at;

  UserModel_Heri({
    required this.uid,
    required this.email,
    required this.username,
    required this.balance,
    required this.created_at,
  });

  factory UserModel_Heri.fromMap(Map<String, dynamic> map) {
    return UserModel_Heri(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      balance: map['balance'] ?? 0,
      created_at: map['created_at'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'balance': balance,
      'created_at': created_at,
    };
  }
}
