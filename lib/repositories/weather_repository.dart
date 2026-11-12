
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherRepository {
  final WeatherService service;

  WeatherRepository(this.service);

  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
  }) {
    return service.getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
