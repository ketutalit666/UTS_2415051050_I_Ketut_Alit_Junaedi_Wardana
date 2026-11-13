
import 'package:flutter/foundation.dart';

import '../models/trip_plan.dart';
import '../repositories/trip_repository.dart';

class TripProvider extends ChangeNotifier {
  final TripRepository repository;

  TripProvider(this.repository);

  List<TripPlan> _trips = [];

  bool _isLoading = false;
  String? _error;

  List<TripPlan> get trips => List.unmodifiable(_trips);

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> loadTrips() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _trips = await repository.getTripPlans();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createTrip(TripPlan trip) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newTrip = await repository.createTrip(trip);
      _trips.insert(0, newTrip);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateTrip(TripPlan trip) async {
    _isLoading = true;
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
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteTrip(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.deleteTrip(id);

      _trips.removeWhere(
        (trip) => trip.id == id,
      );

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
