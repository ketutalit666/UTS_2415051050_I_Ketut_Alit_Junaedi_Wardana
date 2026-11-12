
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather.dart';

class WeatherService {
  static const String _baseUrl =
      'https://api.open-meteo.com/v1/forecast';

  Future<Weather> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'current': [
          'temperature_2m',
          'relative_humidity_2m',
          'apparent_temperature',
          'is_day',
          'weather_code',
          'wind_speed_10m',
        ].join(','),
        'timezone': 'auto',
      },
    );

    final response = await http
        .get(uri)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)
          as Map<String, dynamic>;

      final current = data['current'] as Map<String, dynamic>?;

      if (current == null) {
        throw Exception('Data cuaca tidak tersedia.');
      }

      return Weather.fromJson(current);
    }

    throw Exception(
      'Gagal mengambil data cuaca. '
      'Status: ${response.statusCode}',
    );
  }
}
