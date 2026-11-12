
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/destination_provider.dart';
import 'providers/trip_provider.dart';
import 'repositories/destination_repository.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DestinationProvider(
            DestinationRepository(),
          )..loadDestinations(),
        ),
        ChangeNotifierProvider(
          create: (_) => TripProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'BaliTrip',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const MainPage(),
      ),
    );
  }
}
