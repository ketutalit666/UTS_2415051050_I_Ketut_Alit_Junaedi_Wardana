
import 'package:flutter/foundation.dart';

import '../models/trip_plan.dart';

class TripProvider extends ChangeNotifier {
  final List<TripPlan> _trips = [];

  bool _isLoading = false;
  String? _error;

  List<TripPlan> get trips => List.unmodifiable(_trips);

  bool get isLoading => _isLoading;

  String? get error => _error;

  void addTrip(TripPlan trip) {
    _trips.add(trip);
    notifyListeners();
  }

  void updateTrip(TripPlan updatedTrip) {
    final index = _trips.indexWhere(
      (trip) => trip.id == updatedTrip.id,
    );

    if (index == -1) {
      return;
    }

    _trips[index] = updatedTrip;
    notifyListeners();
  }

  void deleteTrip(int id) {
    _trips.removeWhere((trip) => trip.id == id);
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? message) {
    _error = message;
    notifyListeners();
  }
}
