
class Weather {
  final double temperature;
  final double apparentTemperature;
  final int humidity;
  final double windSpeed;
  final int weatherCode;
  final bool isDay;

  const Weather({
    required this.temperature,
    required this.apparentTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.isDay,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature:
          (json['temperature_2m'] as num?)?.toDouble() ?? 0.0,
      apparentTemperature:
          (json['apparent_temperature'] as num?)?.toDouble() ?? 0.0,
      humidity:
          (json['relative_humidity_2m'] as num?)?.toInt() ?? 0,
      windSpeed:
          (json['wind_speed_10m'] as num?)?.toDouble() ?? 0.0,
      weatherCode:
          (json['weather_code'] as num?)?.toInt() ?? 0,
      isDay: (json['is_day'] as num?)?.toInt() == 1,
    );
  }
}
