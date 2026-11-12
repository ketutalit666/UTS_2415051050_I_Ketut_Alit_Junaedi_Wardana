
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.background,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          const Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.turquoise,
              child: Icon(
                Icons.person_rounded,
                size: 55,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'I Ketut Alit Junaedi Wardana',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.dark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Center(
            child: Text(
              '2415051050',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Card(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.ocean,
                  ),
                  title: const Text('About BaliTrip'),
                  subtitle: const Text('Your Bali travel planner'),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'BaliTrip',
                      applicationVersion: '1.0.0',
                      applicationLegalese:
                          'Aplikasi perencanaan perjalanan wisata Bali.',
                    );
                  },
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(
                    Icons.school_outlined,
                    color: AppColors.ocean,
                  ),
                  title: Text('Student Project'),
                  subtitle: Text('UTS Pemrograman Mobile'),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.ocean,
                  ),
                  title: Text('Location'),
                  subtitle: Text('Bali, Indonesia'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
