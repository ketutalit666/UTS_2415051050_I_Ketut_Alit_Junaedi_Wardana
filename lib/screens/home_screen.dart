
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/destination.dart';
import '../providers/destination_provider.dart';
import '../theme/app_colors.dart';
import 'detail_screen.dart';
import 'explore_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  static const List<Map<String, dynamic>> categories = [
    {
      'name': 'Pantai',
      'icon': Icons.beach_access_rounded,
      'color': Color(0xFF64CCC5),
    },
    {
      'name': 'Alam',
      'icon': Icons.park_rounded,
      'color': Color(0xFF7BC67E),
    },
    {
      'name': 'Budaya',
      'icon': Icons.museum_rounded,
      'color': Color(0xFFFFB86B),
    },
    {
      'name': 'Kuliner',
      'icon': Icons.restaurant_rounded,
      'color': Color(0xFFFF8585),
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openExplore() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ExploreScreen(),
      ),
    );
  }

  void _openProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileScreen(),
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

    if (!mounted) return;

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

  List<Destination> _filterDestinations(
    List<Destination> destinations,
  ) {
    return destinations.where((destination) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          destination.category.toLowerCase() ==
              _selectedCategory.toLowerCase();

      final query = _searchQuery.toLowerCase();

      final matchesSearch =
          destination.name.toLowerCase().contains(query) ||
          destination.location.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _showFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Destinasi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pilih kategori destinasi yang ingin kamu jelajahi.',
                style: TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  'Semua',
                  ...categories.map(
                    (category) => category['name'] as String,
                  ),
                ].map((category) {
                  return ChoiceChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    selectedColor:
                        AppColors.turquoise.withValues(alpha: 0.3),
                    onSelected: (_) {
                      setState(() {
                        _selectedCategory = category;
                      });
                      Navigator.pop(sheetContext);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<DestinationProvider>(
          builder: (context, provider, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;
                final isCompact = screenWidth < 600;
                final isExpanded = screenWidth >= 900;
                final isWide = !isCompact;
                final columns = isExpanded ? 3 : 2;

                final filteredDestinations =
                    _filterDestinations(provider.destinations);

                final heroDestination = provider.destinations.isNotEmpty
                    ? provider.destinations.first
                    : null;

                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 1180),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isCompact ? 0 : 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(isWide),
                            _buildSearchBar(isWide),
                            _buildHeroBanner(
                              isWide,
                              heroDestination,
                            ),
                            _buildSectionTitle(
                              'Explore Categories',
                              'See all',
                              isWide,
                              _openExplore,
                            ),
                            _buildCategories(isWide),
                            _buildSectionTitle(
                              'Popular Destinations',
                              'View all',
                              isWide,
                              _openExplore,
                            ),
                            if (provider.isLoading &&
                                provider.destinations.isEmpty)
                              const Padding(
                                padding: EdgeInsets.all(40),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            else if (provider.error != null &&
                                provider.destinations.isEmpty)
                              _buildError(provider)
                            else if (filteredDestinations.isEmpty)
                              _buildEmptyState()
                            else
                              _buildDestinations(
                                destinations: filteredDestinations,
                                provider: provider,
                                isCompact: isCompact,
                                columns: columns,
                                isExpanded: isExpanded,
                              ),
                            _buildTravelTip(isWide),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(bool isWide) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isWide ? 8 : 22,
        20,
        isWide ? 8 : 22,
        12,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello, Traveler! 👋',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Discover Bali',
                  style: TextStyle(
                    color: AppColors.dark,
                    fontSize: isWide ? 32 : 27,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 15,
                      color: AppColors.coral,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Bali, Indonesia',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Material(
            color: AppColors.turquoise.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: _openProfile,
              borderRadius: BorderRadius.circular(16),
              child: const SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  Icons.person_rounded,
                  color: AppColors.ocean,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isWide) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isWide ? 8 : 22,
        14,
        isWide ? 8 : 22,
        22,
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.trim();
          });
        },
        decoration: InputDecoration(
          hintText: 'Search your destination...',
          hintStyle: const TextStyle(
            color: AppColors.muted,
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.ocean,
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_searchQuery.isNotEmpty)
                IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.muted,
                  ),
                ),
              IconButton(
                tooltip: 'Filter kategori',
                onPressed: _showFilterSheet,
                icon: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: AppColors.ocean,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.tune_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Banner Home menggunakan foto destinasi pertama.
  
  Widget _buildHeroBanner(
    bool isWide,
    Destination? destination,
  ) {
    final heroContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'YOUR NEXT ADVENTURE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Explore the Beauty\nof Bali Island',
          style: TextStyle(
            color: Colors.white,
            fontSize: isWide ? 28 : 23,
            height: 1.15,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'Find amazing places and create\nunforgettable memories.',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _openExplore,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.ocean,
            elevation: 0,
            minimumSize: const Size(120, 38),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          child: const Text(
            'Explore Now',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 8 : 22,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: SizedBox(
          width: double.infinity,
          height: isWide ? 290 : 280,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (destination != null &&
                  destination.imageUrl.isNotEmpty)
                Image.network(
                  destination.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;

                    return Container(
                      color: AppColors.ocean,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.ocean,
                      child: const Icon(
                        Icons.beach_access_rounded,
                        size: 100,
                        color: Colors.white54,
                      ),
                    );
                  },
                )
              else
                Container(color: AppColors.ocean),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.ocean.withValues(alpha: 0.88),
                      AppColors.ocean.withValues(alpha: 0.48),
                      Colors.black.withValues(alpha: 0.12),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(isWide ? 24 : 18),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: isWide ? 420 : 300,
                      child: heroContent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSectionTitle(
    String title,
    String action,
    bool isWide,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isWide ? 8 : 22,
        28,
        isWide ? 8 : 22,
        16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.dark,
              fontSize: isWide ? 20 : 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              action,
              style: const TextStyle(
                color: AppColors.ocean,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(bool isWide) {
    if (isWide) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Wrap(
          spacing: 22,
          runSpacing: 16,
          children: categories.map(_buildCategoryItem).toList(),
        ),
      );
    }

    return SizedBox(
      height: 105,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: 15),
        itemBuilder: (context, index) =>
            _buildCategoryItem(categories[index]),
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    final color = category['color'] as Color;
    final name = category['name'] as String;
    final isSelected = _selectedCategory == name;

    return SizedBox(
      width: 76,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          setState(() {
            _selectedCategory =
                isSelected ? 'Semua' : name;
          });
        },
        child: Column(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: color.withValues(
                  alpha: isSelected ? 0.4 : 0.17,
                ),
                borderRadius: BorderRadius.circular(20),
                border: isSelected
                    ? Border.all(color: color, width: 2)
                    : null,
              ),
              child: Icon(
                category['icon'] as IconData,
                color: color,
                size: 29,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                color: AppColors.dark,
                fontSize: 12,
                fontWeight: isSelected
                    ? FontWeight.w800
                    : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinations({
    required List<Destination> destinations,
    required DestinationProvider provider,
    required bool isCompact,
    required int columns,
    required bool isExpanded,
  }) {
    if (isCompact) {
      return SizedBox(
        height: 225,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          scrollDirection: Axis.horizontal,
          itemCount: destinations.length,
          separatorBuilder: (context, index) =>
              const SizedBox(width: 15),
          itemBuilder: (context, index) {
            return SizedBox(
              width: 205,
              child: _buildDestinationCard(
                destinations[index],
                provider,
              ),
            );
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: destinations.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: isExpanded ? 1.35 : 1.15,
        ),
        itemBuilder: (context, index) {
          return _buildDestinationCard(
            destinations[index],
            provider,
          );
        },
      ),
    );
  }

  Widget _buildDestinationCard(
    Destination destination,
    DestinationProvider provider,
  ) {
    final color = _categoryColor(destination.category);
    final icon = _categoryIcon(destination.category);
    final isFavorite = provider.isFavorite(destination.id);

    return Material(  
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openDetail(destination),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.dark.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
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
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;

                          return Container(
                            color: color.withValues(alpha: 0.2),
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: color,
                            child: Icon(
                              icon,
                              size: 65,
                              color: Colors.white,
                            ),
                          );
                        },
                      )
                    else
                      Container(
                        color: color,
                        child: Icon(
                          icon,
                          size: 65,
                          color: Colors.white,
                        ),
                      ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          destination.rating >= 4.8
                              ? 'Popular'
                              : destination.category,
                          style: const TextStyle(
                            color: AppColors.dark,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            _toggleFavorite(destination, provider);
                          },
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: AppColors.coral,
                            size: 19,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.dark,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 13,
                          color: AppColors.muted,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            destination.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.sunny,
                          size: 15,
                        ),
                        Text(
                          destination.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: AppColors.dark,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'pantai':
        return const Color(0xFF64CCC5);
      case 'alam':
        return const Color(0xFF7BC67E);
      case 'budaya':
        return const Color(0xFFFFB86B);
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

  Widget _buildError(DestinationProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 38,
            ),
            const SizedBox(height: 10),
            Text(
              provider.error ?? 'Terjadi kesalahan.',
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

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 42,
              color: AppColors.muted,
            ),
            const SizedBox(height: 10),
            const Text(
              'Destinasi tidak ditemukan.',
              style: TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: _clearFilters,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reset pencarian dan filter'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTravelTip(bool isWide) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        isWide ? 8 : 22,
        28,
        isWide ? 8 : 22,
        10,
      ),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3DD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.lightbulb_rounded,
            color: Color(0xFFE59A27),
            size: 30,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Travel Tip',
                  style: TextStyle(
                    color: AppColors.dark,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Explore Bali in the morning for a more comfortable journey!',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
