
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/destination_provider.dart';
import '../providers/trip_provider.dart';
import '../theme/app_colors.dart';
import 'add_itinerary_screen.dart';
import 'edit_itinerary_screen.dart';

class MyTripsScreen extends StatelessWidget {
  const MyTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'My Trips',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
      ),
      body: Consumer2<TripProvider, DestinationProvider>(
        builder: (
          context,
          tripProvider,
          destinationProvider,
          child,
        ) {
          final trips = tripProvider.trips;
          final favorites = destinationProvider.favorites;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.ocean,
                      AppColors.turquoise,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.luggage_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Your Journey Starts Here!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Organize your favorite Bali destinations.',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Planned Trips Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Planned Trips',
                    style: TextStyle(
                      color: AppColors.dark,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const AddItineraryScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add New'),
                  ),
                ],
              ),

              // Loading State
              if (tripProvider.isLoading && trips.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )

              // Error State
              else if (tripProvider.error != null &&
                  trips.isEmpty)
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: AppColors.coral,
                          size: 40,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Failed to load trips',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.dark,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          tripProvider.error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.muted,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: tripProvider.loadTrips,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                )

              // Empty State
              else if (trips.isEmpty)
                const Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(22),
                    child: Column(
                      children: [
                        Icon(
                          Icons.event_note_rounded,
                          size: 42,
                          color: AppColors.muted,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No trips planned yet',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.dark,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Start planning your Bali adventure!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              // Trip List
              else
                ...trips.map(
                  (trip) => Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      leading: const CircleAvatar(
                        backgroundColor: Color(0x2264CCC5),
                        child: Icon(
                          Icons.luggage_rounded,
                          color: AppColors.ocean,
                        ),
                      ),
                      title: Text(
                        trip.destinationName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.dark,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '${trip.visitDate.day}/'
                          '${trip.visitDate.month}/'
                          '${trip.visitDate.year} • '
                          '${trip.status}\n'
                          '${trip.notes}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                      isThreeLine: true,
                      trailing: trip.id == null
                          ? null
                          : IconButton(
                              tooltip: 'Edit itinerary',
                              icon: const Icon(
                                Icons.edit_rounded,
                                color: AppColors.ocean,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EditItineraryScreen(
                                      trip: trip,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // Favorite Destinations Header
              const Text(
                'Favorite Destinations',
                style: TextStyle(
                  color: AppColors.dark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Favorite Empty State
              if (favorites.isEmpty)
                const Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Text(
                      'Belum ada destinasi favorit. '
                      'Tambahkan favorit melalui halaman Explore.',
                      style: TextStyle(
                        color: AppColors.muted,
                      ),
                    ),
                  ),
                )

              // Favorite List
              else
                ...favorites.map(
                  (destination) => Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: const Icon(
                        Icons.favorite,
                        color: AppColors.coral,
                      ),
                      title: Text(destination.name),
                      subtitle: Text(destination.location),
                      trailing: IconButton(
                        onPressed: () {
                          destinationProvider.toggleFavorite(
                            destination.id,
                          );
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: AppColors.coral,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
