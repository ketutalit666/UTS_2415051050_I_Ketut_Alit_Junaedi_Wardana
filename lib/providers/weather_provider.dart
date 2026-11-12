
import 'package:flutter/foundation.dart';

import '../models/destination.dart';
import '../models/weather.dart';
import '../repositories/weather_repository.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository repository;

  WeatherProvider(this.repository);

  final Map<String, Weather> _weatherData = {};
  final Set<String> _loadingIds = {};
  final Map<String, String> _errors = {};

  Weather? getWeather(String destinationId) {
    return _weatherData[destinationId];
  }

  bool isLoading(String destinationId) {
    return _loadingIds.contains(destinationId);
  }

  String? getError(String destinationId) {
    return _errors[destinationId];
  }

  Future<void> loadWeather(Destination destination) async {
    final id = destination.id;

    if (_loadingIds.contains(id)) return;

    _loadingIds.add(id);
    _errors.remove(id);
    notifyListeners();

    try {
      final weather = await repository.getWeather(
        latitude: destination.latitude,
        longitude: destination.longitude,
      );

      _weatherData[id] = weather;
    } catch (e) {
      _errors[id] = e.toString();
    } finally {
      _loadingIds.remove(id);
      notifyListeners();
    }
  }

  void retryWeather(Destination destination) {
    loadWeather(destination);
  }
}
