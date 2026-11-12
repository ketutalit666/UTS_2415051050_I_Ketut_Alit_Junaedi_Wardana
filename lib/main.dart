
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BaliTripApp());
}

class BaliTripApp extends StatelessWidget {
  const BaliTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BaliTrip',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text(
            'BaliTrip\nDiscover Bali, Plan Your Journey',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
