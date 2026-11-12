
import '../data/destinations_data.dart';
import '../models/destination.dart';

class DestinationRepository {
  Future<List<Destination>> getDestinations() async {
    return destinationsData;
  }
}
