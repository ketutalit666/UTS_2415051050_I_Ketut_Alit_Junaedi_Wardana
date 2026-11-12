
import 'package:flutter/material.dart';

import 'providers/app_providers.dart';
import 'screens/main_page.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BaliTripApp());
}

class BaliTripApp extends StatelessWidget {
  const BaliTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        title: 'BaliTrip',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const MainPage(),
      ),
    );
  }
}
