
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/trip_plan.dart';

class TripService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<TripPlan>> getTripPlans() async {
    final response = await _client
        .from('trip_plans')
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map(
          (item) => TripPlan.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();
  }

  Future<TripPlan> createTrip(TripPlan trip) async {
    final response = await _client
        .from('trip_plans')
        .insert({
          'destination_name': trip.destinationName,
          'visit_date': trip.visitDate.toIso8601String().split('T').first,
          'notes': trip.notes,
          'status': trip.status,
        })
        .select()
        .single();

    return TripPlan.fromJson(
      Map<String, dynamic>.from(response),
    );
  }
}
