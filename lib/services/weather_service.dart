
import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

    try {
      final response = await http
          .get(uri)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is! Map<String, dynamic>) {
          throw const FormatException(
            'Format respons API tidak valid.',
          );
        }

        final current = data['current'];

        if (current is! Map<String, dynamic>) {
          throw const FormatException(
            'Data cuaca tidak tersedia.',
          );
        }

        return Weather.fromJson(current);
      }

      if (response.statusCode == 400) {
        throw Exception(
          'Permintaan data cuaca tidak valid.',
        );
      }

      if (response.statusCode == 429) {
        throw Exception(
          'Terlalu banyak permintaan. Coba beberapa saat lagi.',
        );
      }

      if (response.statusCode >= 500) {
        throw Exception(
          'Server cuaca sedang bermasalah. Coba kembali nanti.',
        );
      }

      throw Exception(
        'Gagal mengambil data cuaca. '
        'Kode: ${response.statusCode}.',
      );
    } on SocketException {
      throw Exception(
        'Tidak ada koneksi internet. Periksa jaringan Anda.',
      );
    } on TimeoutException {
      throw Exception(
        'Koneksi ke server terlalu lama. Silakan coba kembali.',
      );
    } on http.ClientException {
      throw Exception(
        'Tidak dapat terhubung ke layanan cuaca.',
      );
    } on FormatException {
      throw Exception(
        'Format data cuaca dari server tidak valid.',
      );
    }
  }
}
