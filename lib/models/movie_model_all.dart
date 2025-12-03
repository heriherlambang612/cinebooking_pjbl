import 'package:cloud_firestore/cloud_firestore.dart';

class MovieModel_all {
  String movie_id;
  String title;
  String poster_url;
  int base_price;
  double rating;
  int duration;

  MovieModel_all({required this.movie_id, required this.title, required this.poster_url, required this.base_price, required this.rating, required this.duration});

  factory MovieModel_all.fromMap(Map<String, dynamic> map) {
    return MovieModel_all(
      movie_id: map['movie_id'] ?? '',
      title: map['title'] ?? '',
      poster_url: map['poster_url'] ?? '',
      base_price: map['base_price'] ?? 0,
      rating: (map['rating'] ?? 0.0).toDouble(),
      duration: map['duration'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {'movie_id': movie_id, 'title': title, 'poster_url': poster_url, 'base_price': base_price, 'rating': rating, 'duration': duration};
  }
}

class UserModel {
  String uid;
  String email;
  String username;
  int balance;
  DateTime created_at;

  UserModel({required this.uid, required this.email, required this.username, required this.balance, required this.created_at});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(uid: map['uid'] ?? '', email: map['email'] ?? '', username: map['username'] ?? '', balance: map['balance'] ?? 0, created_at: (map['created_at'] as Timestamp).toDate());
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'username': username, 'balance': balance, 'created_at': Timestamp.fromDate(created_at)};
  }
}
