
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/destination.dart';
import '../providers/destination_provider.dart';
import '../theme/app_colors.dart';
import 'detail_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

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
      ),
      body: Consumer<DestinationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(provider.error!),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: provider.loadDestinations,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (provider.destinations.isEmpty) {
            return const Center(
              child: Text('Belum ada destinasi tersedia.'),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 900
                  ? 3
                  : constraints.maxWidth >= 600
                      ? 2
                      : 1;

              if (columns == 1) {
                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: provider.destinations.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _destinationCard(
                        context,
                        provider.destinations[index],
                        provider,
                      ),
                    );
                  },
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: provider.destinations.length,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  return _destinationCard(
                    context,
                    provider.destinations[index],
                    provider,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _destinationCard(
    BuildContext context,
    Destination destination,
    DestinationProvider provider,
  ) {
    final isFavorite = provider.isFavorite(destination.id);

    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
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
                color: _categoryColor(destination.category),
                child: Icon(
                  _categoryIcon(destination.category),
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          destination.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.dark,
                          ),
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          provider.toggleFavorite(destination.id);
                        },
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppColors.coral,
                        ),
                      ),
                    ],
                  ),
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
                          destination.location,
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
                      Text(destination.rating.toString()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
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

  Color _categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'pantai':
        return AppColors.turquoise;
      case 'budaya':
        return AppColors.coral;
      default:
        return AppColors.ocean;
    }
  }

  IconData _categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'pantai':
        return Icons.waves_rounded;
      case 'budaya':
        return Icons.temple_hindu_rounded;
      default:
        return Icons.landscape_rounded;
    }
  }
}
