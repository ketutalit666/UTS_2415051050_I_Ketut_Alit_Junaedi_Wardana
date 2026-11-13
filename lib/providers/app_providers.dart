
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/destination_repository.dart';
import '../repositories/trip_repository.dart';
import '../repositories/weather_repository.dart';
import '../services/trip_service.dart';
import '../services/weather_service.dart';
import 'destination_provider.dart';
import 'trip_provider.dart';
import 'weather_provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    super.key,
    required this.child,
  });

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
          create: (_) => TripProvider(
            TripRepository(
              TripService(),
            ),
          )..loadTrips(),
        ),
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(
            WeatherRepository(
              WeatherService(),
            ),
          ),
        ),
      ],
      child: child,
    );
  }
}
