
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/destination.dart';
import '../models/weather.dart';
import '../providers/weather_provider.dart';
import '../theme/app_colors.dart';
import 'add_itinerary_screen.dart';

class DetailScreen extends StatefulWidget {
  final Destination destination;

  const DetailScreen({
    super.key,
    required this.destination,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<WeatherProvider>().loadWeather(
            widget.destination,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Destination Detail'),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.turquoise,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.landscape_rounded,
                size: 110,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              destination.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.coral,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    destination.location,
                    style: const TextStyle(
                      color: AppColors.muted,
                    ),
                  ),
                ),
                const Icon(
                  Icons.star_rounded,
                  color: AppColors.sunny,
                ),
                Text(destination.rating.toString()),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'About Destination',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              destination.description,
              style: const TextStyle(
                color: AppColors.muted,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
            _buildWeatherSection(destination),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddItineraryScreen(
                        destinationName: destination.name,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add_road_rounded),
                label: const Text('Add to My Trips'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.ocean,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherSection(Destination destination) {
    return Consumer<WeatherProvider>(
      builder: (context, provider, child) {
        final weather = provider.getWeather(destination.id);
        final isLoading = provider.isLoading(destination.id);
        final error = provider.getError(destination.id);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.cloud_rounded,
                    color: AppColors.ocean,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Current Weather',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (error != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cuaca gagal dimuat: $error',
                      style: const TextStyle(
                        color: AppColors.error,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        provider.retryWeather(destination);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                )
              else if (weather != null)
                _weatherDetails(weather)
              else
                const Text('Data cuaca belum tersedia.'),
              const SizedBox(height: 12),
              const Text(
                'Weather data: Open-Meteo',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _weatherDetails(Weather weather) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              weather.isDay
                  ? Icons.wb_sunny_rounded
                  : Icons.nightlight_round,
              color: AppColors.sunny,
              size: 45,
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${weather.temperature.toStringAsFixed(1)} °C',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
                Text(
                  'Terasa seperti '
                  '${weather.apparentTemperature.toStringAsFixed(1)} °C',
                  style: const TextStyle(
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Divider(height: 28),
        Row(
          children: [
            Expanded(
              child: _weatherInfo(
                Icons.water_drop_outlined,
                'Humidity',
                '${weather.humidity}%',
              ),
            ),
            Expanded(
              child: _weatherInfo(
                Icons.air_rounded,
                'Wind Speed',
                '${weather.windSpeed} km/h',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _weatherDescription(weather.weatherCode),
            style: const TextStyle(
              color: AppColors.ocean,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _weatherInfo(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, color: AppColors.ocean),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.muted,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _weatherDescription(int code) {
    if (code == 0) return 'Cerah';
    if (code <= 3) return 'Cerah berawan';
    if (code <= 48) return 'Berkabut';
    if (code <= 67) return 'Hujan';
    if (code <= 77) return 'Salju';
    if (code <= 82) return 'Hujan lokal';
    if (code <= 86) return 'Hujan salju';
    if (code <= 99) return 'Badai petir';

    return 'Kondisi cuaca tidak diketahui';
  }
}
