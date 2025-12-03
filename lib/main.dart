import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/movie_detail_screen.dart';
import 'screens/seat_selection_screen.dart';
import 'providers/booking_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BookingProvider(), lazy: false)],
      child: MaterialApp(
        title: 'CineBooking',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),

        home: LoginScreen(),

        routes: {'/login': (context) => LoginScreen(), '/register': (context) => RegisterScreen(), '/home': (context) => HomeScreen(), '/profile': (context) => ProfileScreen()},
      ),
    );
  }
}
