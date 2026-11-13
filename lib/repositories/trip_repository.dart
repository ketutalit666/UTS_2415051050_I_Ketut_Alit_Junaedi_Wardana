
import '../models/trip_plan.dart';
import '../services/trip_service.dart';

class TripRepository {
  final TripService service;

  TripRepository(this.service);

  Future<List<TripPlan>> getTripPlans() {
    return service.getTripPlans();
  }
}
