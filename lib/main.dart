
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
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
      home: const HomeScreen(),
    );
  }
}
