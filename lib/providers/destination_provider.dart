
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/destination.dart';
import '../repositories/destination_repository.dart';

class DestinationProvider extends ChangeNotifier {
  final DestinationRepository repository;

  DestinationProvider(this.repository) {
    _favoriteLoadFuture = _loadFavorites();
  }

  static const String _favoriteStorageKey = 'favorite_destination_ids';

  List<Destination> _destinations = [];
  final Set<String> _favoriteIds = {};

  bool _isLoading = false;
  String? _error;

  late final Future<void> _favoriteLoadFuture;

  Future<void> _saveQueue = Future<void>.value();

  List<Destination> get destinations => _destinations;

  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  List<Destination> get favorites {
    return _destinations
        .where((destination) => _favoriteIds.contains(destination.id))
        .toList();
  }

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final savedIds =
          prefs.getStringList(_favoriteStorageKey) ?? [];

      _favoriteIds
        ..clear()
        ..addAll(savedIds);

      notifyListeners();
    } catch (e) {
      debugPrint('Gagal memuat data favorit: $e');
    }
  }

  Future<void> _persistFavorites() {
    final savedIds = _favoriteIds.toList();

    _saveQueue = _saveQueue.then((_) async {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setStringList(
        _favoriteStorageKey,
        savedIds,
      );
    });

    return _saveQueue;
  }

  Future<void> loadDestinations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _favoriteLoadFuture;
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

  Future<void> toggleFavorite(String destinationId) async {
    // Pastikan data favorit lama selesai dimuat terlebih dahulu.
    await _favoriteLoadFuture;

    if (_favoriteIds.contains(destinationId)) {
      _favoriteIds.remove(destinationId);
    } else {
      _favoriteIds.add(destinationId);
    }

    // Perbarui tampilan.
    notifyListeners();

    // Simpan perubahan secara permanen.
    try {
      await _persistFavorites();
    } catch (e) {
      debugPrint('Gagal menyimpan data favorit: $e');
    }
  }
}
