
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/destination.dart';
import '../providers/destination_provider.dart';
import '../theme/app_colors.dart';
import 'detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String _searchQuery = '';
  String _selectedCategory = 'Semua';

  static const List<String> _categories = [
    'Semua',
    'Pantai',
    'Alam',
    'Budaya',
    'Kuliner',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Destination> _filterDestinations(
    List<Destination> destinations,
  ) {
    return destinations.where((destination) {
      final categoryMatches = _selectedCategory == 'Semua' ||
          destination.category.toLowerCase() ==
              _selectedCategory.toLowerCase();

      final query = _searchQuery.toLowerCase();

      final searchMatches =
          destination.name.toLowerCase().contains(query) ||
          destination.location.toLowerCase().contains(query);

      return categoryMatches && searchMatches;
    }).toList();
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _selectedCategory = 'Semua';
    });
  }

  void _toggleFavorite(
    Destination destination,
    DestinationProvider provider,
  ) {
    final wasFavorite = provider.isFavorite(destination.id);

    provider.toggleFavorite(destination.id);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            wasFavorite
                ? '${destination.name} dihapus dari favorit.'
                : '${destination.name} ditambahkan ke favorit.',
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _openDetail(Destination destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(destination: destination),
      ),
    );
  }

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
          if (provider.isLoading &&
              provider.destinations.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.error != null &&
              provider.destinations.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      size: 42,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      provider.error!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: provider.loadDestinations,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final destinations =
              _filterDestinations(provider.destinations);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.trim();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari nama atau lokasi destinasi...',
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.ocean,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            tooltip: 'Hapus pencarian',
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                            icon: const Icon(Icons.close_rounded),
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 52,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 6,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final selected =
                        _selectedCategory == category;

                    return ChoiceChip(
                      label: Text(category),
                      selected: selected,
                      selectedColor: AppColors.turquoise
                          .withValues(alpha: 0.35),
                      onSelected: (_) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${destinations.length} destinasi ditemukan',
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (_searchQuery.isNotEmpty ||
                        _selectedCategory != 'Semua')
                      TextButton(
                        onPressed: _clearFilters,
                        child: const Text('Reset filter'),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: destinations.isEmpty
                    ? _buildEmptyState()
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          final columns =
                              constraints.maxWidth >= 900
                                  ? 3
                                  : constraints.maxWidth >= 600
                                      ? 2
                                      : 1;

                          if (columns == 1) {
                            return ListView.builder(
                              padding: const EdgeInsets.fromLTRB(
                                20,
                                4,
                                20,
                                20,
                              ),
                              itemCount: destinations.length,
                              itemBuilder: (context, index) {
                                final destination =
                                    destinations[index];

                                return SizedBox(
                                  height: 230,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(
                                      bottom: 14,
                                    ),
                                    child: _destinationCard(
                                      destination,
                                      provider,
                                    ),
                                  ),
                                );
                              },
                            );
                          }

                          return GridView.builder(
                            padding: const EdgeInsets.all(20),
                            itemCount: destinations.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columns,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio:
                                  constraints.maxWidth >= 900
                                      ? 1.15
                                      : 1.0,
                            ),
                            itemBuilder: (context, index) {
                              return _destinationCard(
                                destinations[index],
                                provider,
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 52,
              color: AppColors.muted,
            ),
            const SizedBox(height: 12),
            const Text(
              'Destinasi tidak ditemukan.',
              style: TextStyle(
                color: AppColors.dark,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Coba kata kunci atau kategori lainnya.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _clearFilters,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reset pencarian'),
            ),
          ],
        ),
      ),
    );
  }

  
    Widget _destinationCard(
      Destination destination,
      DestinationProvider provider,
    ) {
      final isFavorite = provider.isFavorite(destination.id);
      final categoryColor = _categoryColor(destination.category);

      return Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () => _openDetail(destination),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (destination.imageUrl.isNotEmpty)
                      Image.network(
                        destination.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return _imageFallback(categoryColor, destination);
                        },
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;

                          return Container(
                            color: categoryColor.withValues(alpha: 0.15),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      )
                    else
                      _imageFallback(categoryColor, destination),

                    Positioned(
                      top: 10,
                      right: 10,
                      child: Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        child: IconButton(
                          tooltip: isFavorite
                              ? 'Hapus dari favorit'
                              : 'Tambahkan ke favorit',
                          visualDensity: VisualDensity.compact,
                          onPressed: () => _toggleFavorite(
                            destination,
                            provider,
                          ),
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: AppColors.coral,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: categoryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          destination.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.dark,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 8),
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                        const SizedBox(width: 3),
                        Text(destination.rating.toStringAsFixed(1)),
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

    Widget _imageFallback(
      Color categoryColor,
      Destination destination,
    ) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              categoryColor.withValues(alpha: 0.65),
              categoryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Icon(
          _categoryIcon(destination.category),
          size: 65,
          color: Colors.white,
        ),
      );
    
  }

  Color _categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'pantai':
        return AppColors.turquoise;
      case 'alam':
        return const Color(0xFF7BC67E);
      case 'budaya':
        return AppColors.coral;
      case 'kuliner':
        return const Color(0xFFFF8585);
      default:
        return AppColors.ocean;
    }
  }

  IconData _categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'pantai':
        return Icons.waves_rounded;
      case 'alam':
        return Icons.landscape_rounded;
      case 'budaya':
        return Icons.temple_hindu_rounded;
      case 'kuliner':
        return Icons.restaurant_rounded;
      default:
        return Icons.place_rounded;
    }
  }
}
