
import 'package:flutter/foundation.dart';

import '../models/destination.dart';
import '../repositories/destination_repository.dart';

class DestinationProvider extends ChangeNotifier {
  final DestinationRepository repository;

  DestinationProvider(this.repository);

  List<Destination> _destinations = [];
  final Set<String> _favoriteIds = {};

  bool _isLoading = false;
  String? _error;

  List<Destination> get destinations => _destinations;

  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  List<Destination> get favorites {
    return _destinations
        .where((destination) => _favoriteIds.contains(destination.id))
        .toList();
  }

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> loadDestinations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _destinations = await repository.getDestinations();
    } catch (e) {
      _error = 'Gagal memuat destinasi: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isFavorite(String destinationId) {
    return _favoriteIds.contains(destinationId);
  }

  void toggleFavorite(String destinationId) {
    if (_favoriteIds.contains(destinationId)) {
      _favoriteIds.remove(destinationId);
    } else {
      _favoriteIds.add(destinationId);
    }

    notifyListeners();
  }
}
