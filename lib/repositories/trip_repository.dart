
import '../models/trip_plan.dart';
import '../services/trip_service.dart';

class TripRepository {
  final TripService service;

  TripRepository(this.service);

  Future<List<TripPlan>> getTripPlans() {
    return service.getTripPlans();
  }

  Future<TripPlan> createTrip(TripPlan trip) {
    return service.createTrip(trip);
  }

  Future<TripPlan> updateTrip(TripPlan trip) {
    return service.updateTrip(trip);
  }

  Future<void> deleteTrip(int id) {
    return service.deleteTrip(id);
  }
}
