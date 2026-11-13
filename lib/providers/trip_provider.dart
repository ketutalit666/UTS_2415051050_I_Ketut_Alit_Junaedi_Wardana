import 'package:flutter/foundation.dart';

import '../models/trip_plan.dart';
import '../repositories/trip_repository.dart';

class TripProvider extends ChangeNotifier {
  final TripRepository repository;

  TripProvider(this.repository);

  List<TripPlan> _trips = [];

  bool _isLoading = false;
  bool _isCreating = false;
  bool _isUpdating = false;
  bool _isDeleting = false;

  int? _deletingTripId;

  String? _error;

  List<TripPlan> get trips => List.unmodifiable(_trips);

  bool get isLoading => _isLoading;
  bool get isCreating => _isCreating;
  bool get isUpdating => _isUpdating;
  bool get isDeleting => _isDeleting;

  int? get deletingTripId => _deletingTripId;

  bool get isMutating =>
      _isCreating || _isUpdating || _isDeleting;

  String? get error => _error;

  String _friendlyError(Object error) {
    final message = error.toString().toLowerCase();

    if (message.contains('socketexception') ||
        message.contains('network') ||
        message.contains('connection')) {
      return 'Koneksi internet bermasalah. Periksa jaringan Anda.';
    }

    if (message.contains('timeout')) {
      return 'Permintaan terlalu lama. Silakan coba kembali.';
    }

    if (message.contains('permission') ||
        message.contains('row-level security') ||
        message.contains('42501')) {
      return 'Akses database ditolak. Periksa izin database.';
    }

    return 'Terjadi kesalahan saat mengakses database. Silakan coba kembali.';
  }

  Future<void> loadTrips() async {
    if (_isLoading || isMutating) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _trips = await repository.getTripPlans();
    } catch (e) {
      _error = _friendlyError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createTrip(TripPlan trip) async {
    if (isMutating) return false;

    _isCreating = true;
    _error = null;
    notifyListeners();

    try {
      final newTrip = await repository.createTrip(trip);
      _trips.insert(0, newTrip);
      return true;
    } catch (e) {
      _error = _friendlyError(e);
      return false;
    } finally {
      _isCreating = false;
      notifyListeners();
    }
  }

  Future<bool> updateTrip(TripPlan trip) async {
    if (isMutating) return false;

    _isUpdating = true;
    _error = null;
    notifyListeners();

    try {
      final updatedTrip = await repository.updateTrip(trip);

      final index = _trips.indexWhere(
        (item) => item.id == updatedTrip.id,
      );

      if (index != -1) {
        _trips[index] = updatedTrip;
      }

      return true;
    } catch (e) {
      _error = _friendlyError(e);
      return false;
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

  Future<bool> deleteTrip(int id) async {
    if (isMutating) return false;

    _isDeleting = true;
    _deletingTripId = id;
    _error = null;
    notifyListeners();

    try {
      await repository.deleteTrip(id);

      _trips.removeWhere(
        (trip) => trip.id == id,
      );

      return true;
    } catch (e) {
      _error = _friendlyError(e);
      return false;
    } finally {
      _isDeleting = false;
      _deletingTripId = null;
      notifyListeners();
    }
  }
}