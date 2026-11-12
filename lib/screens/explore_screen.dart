
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'detail_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  static const List<Map<String, dynamic>> destinations = [
    {
      'name': 'Pantai Kelingking',
      'location': 'Nusa Penida',
      'rating': '4.9',
      'description':
          'Pantai Kelingking terkenal dengan tebing berbentuk seperti T-Rex dan pemandangan laut yang indah.',
      'icon': Icons.waves_rounded,
      'color': Color(0xFF64CCC5),
      'category': 'Pantai',
    },
    {
      'name': 'Pura Lempuyang',
      'location': 'Karangasem',
      'rating': '4.8',
      'description':
          'Pura Lempuyang merupakan salah satu tempat wisata budaya terkenal di Bali dengan pemandangan Gunung Agung.',
      'icon': Icons.temple_hindu_rounded,
      'color': Color(0xFFFFB86B),
      'category': 'Budaya',
    },
    {
      'name': 'Tegallalang Rice Terrace',
      'location': 'Gianyar',
      'rating': '4.8',
      'description':
          'Tegallalang menawarkan pemandangan sawah berundak yang hijau dan suasana alam yang menenangkan.',
      'icon': Icons.landscape_rounded,
      'color': Color(0xFF7BC67E),
      'category': 'Alam',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Explore Bali',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 900
              ? 3
              : constraints.maxWidth >= 600
                  ? 2
                  : 1;

          if (columns == 1) {
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _destinationCard(
                    context,
                    destinations[index],
                  ),
                );
              },
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: destinations.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              return _destinationCard(
                context,
                destinations[index],
              );
            },
          );
        },
      ),
    );
  }

  Widget _destinationCard(
    BuildContext context,
    Map<String, dynamic> destination,
  ) {
    final color = destination['color'] as Color;

    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(
                destination: destination,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.7),
                      color,
                    ],
                  ),
                ),
                child: Icon(
                  destination['icon'] as IconData,
                  size: 75,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination['name'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.muted,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          destination['location'] as String,
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: AppColors.sunny,
                      ),
                      Text(destination['rating'] as String),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lihat detail',
                    style: TextStyle(
                      color: AppColors.ocean,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
