
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
}
