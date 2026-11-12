
import 'package:flutter/material.dart';

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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.background,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
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
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
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
                      builder: (_) => const AddItineraryScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Card(
            color: Colors.white,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0x2264CCC5),
                child: Icon(
                  Icons.waves_rounded,
                  color: AppColors.ocean,
                ),
              ),
              title: const Text(
                'Pantai Kelingking',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('20 November 2026'),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit_rounded,
                  color: AppColors.ocean,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditItineraryScreen(
                        destinationName: 'Pantai Kelingking',
                        travelDate: '20 November 2026',
                        notes: 'Explore Nusa Penida',
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Contoh perjalanan sementara. Fitur penyimpanan dan pengelolaan data akan dibuat pada tahap database dan CRUD.',
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
