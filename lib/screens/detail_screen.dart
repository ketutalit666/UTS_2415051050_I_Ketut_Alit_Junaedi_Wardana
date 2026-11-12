
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'add_itinerary_screen.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> destination;

  const DetailScreen({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    final color = destination['color'] as Color;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Destination Detail'),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.7),
                    color,
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                destination['icon'] as IconData,
                size: 110,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              destination['name'] as String,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.coral,
                ),
                const SizedBox(width: 5),
                Text(
                  destination['location'] as String,
                  style: const TextStyle(color: AppColors.muted),
                ),
                const Spacer(),
                const Icon(
                  Icons.star_rounded,
                  color: AppColors.sunny,
                ),
                Text(destination['rating'] as String),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'About Destination',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              destination['description'] as String,
              style: const TextStyle(
                color: AppColors.muted,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddItineraryScreen(
                        destinationName:
                            destination['name'] as String,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add_road_rounded),
                label: const Text('Add to My Trips'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.ocean,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
