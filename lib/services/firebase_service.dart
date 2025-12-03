import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // REGISTER USER
  static Future<User?> register(
    String email,
    String password,
    String username,
  ) async {
    try {
      // Create User in Auth
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      // Save User Data in Firestore
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'username': username,
        'balance': 0,
        'created_at': Timestamp.now(),
      });

      return credential.user;
    } on FirebaseAuthException catch (e) {
      // If an auth error occurs, throw it to UI for snackbar
      throw e.message ?? "Unknown FirebaseAuth error";
    } catch (e) {
      throw "Failed to register user: $e";
    }
  }

  // LOGIN USER
  static Future<User?> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Login failed";
    } catch (e) {
      throw "Error: $e";
    }
  }

  // LOGOUT
  static Future<void> logout() async {
    await _auth.signOut();
  }

  // CURRENT USER
  static User? get currentUser => _auth.currentUser;

  // GET MOVIES
  static Stream<QuerySnapshot> getMovies() {
    return _firestore.collection('movies').snapshots();
  }

  // ADD BOOKING
  static Future<void> addBooking(Map<String, dynamic> bookingData) async {
    try {
      await _firestore.collection('bookings').add(bookingData);
    } catch (e) {
      throw "Failed to save booking: $e";
    }
  }

  // GET USER BOOKINGS
  static Stream<QuerySnapshot> getUserBookings(String userId) {
    return _firestore
        .collection('bookings')
        .where('user_id', isEqualTo: userId)
        .orderBy('booking_date', descending: true)
        .snapshots();
  }
}
