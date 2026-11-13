
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
          'visit_date':
              trip.visitDate.toIso8601String().split('T').first,
          'notes': trip.notes,
          'status': trip.status,
        })
        .select()
        .single();

    return TripPlan.fromJson(
      Map<String, dynamic>.from(response),
    );
  }

  Future<TripPlan> updateTrip(TripPlan trip) async {
    if (trip.id == null) {
      throw Exception('Trip ID is missing.');
    }

    final response = await _client
        .from('trip_plans')
        .update({
          'destination_name': trip.destinationName,
          'visit_date':
              trip.visitDate.toIso8601String().split('T').first,
          'notes': trip.notes,
          'status': trip.status,
        })
        .eq('id', trip.id!)
        .select()
        .single();

    return TripPlan.fromJson(
      Map<String, dynamic>.from(response),
    );
  }

  Future<void> deleteTrip(int id) async {
    final response = await _client
        .from('trip_plans')
        .delete()
        .eq('id', id)
        .select('id');

    if (response.isEmpty) {
      throw Exception(
        'Trip was not deleted. Check database permissions.',
      );
    }
  }
}
