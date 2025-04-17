import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/saved_location.dart';
import '../services/weather_services.dart';

class LocationScreen extends StatefulWidget {
  final SavedLocation location;

  const LocationScreen({super.key, required this.location});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final WeatherService _weatherService = WeatherService();

  bool _isLoading = true;
  Map<String, dynamic>? _weatherData;
  Map<String, dynamic>? _summaryData;

  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final data = await _weatherService.fetchWeather(widget.location.city);
      setState(() {
        _weatherData = data['weather'];
        _summaryData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Failed to load weather.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF047BFF), // Light blue
              Color(0xFF111111), // Deep black at the bottom
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                ? Center(child: Text(_error!))
                : _buildWeatherDetails(),
      ),
    );
  }

  Widget _buildWeatherDetails() {
    final summary = _summaryData?['summary'];

    final city = _weatherData?['name'];
    final country = _weatherData?['sys']?['country'];

    final temp = _weatherData?['main']?['temp'];
    final feels_like = _weatherData?['main']?['feels_like'];
    final wind_speed = _weatherData?['wind']?['speed'];
    final humidity = _weatherData?['main']?['humidity'];

    final temp_max = _weatherData?['main']?['temp_max'];
    final temp_min = _weatherData?['main']?['temp_min'];

    final visibility = _weatherData?['visibility'];

    final description = _weatherData?['weather']?[0]?['description'];
    final icon = _weatherData?['weather']?[0]?['icon'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 80),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$city, $country",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "$description",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Image.network(
                    "http://openweathermap.org/img/wn/$icon@4x.png",
                    width: 80,
                    height: 80,
                  ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        const SizedBox(height: 20),

        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.black.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${temp.toStringAsFixed(1)}°C",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Feels like ${feels_like.toStringAsFixed(1)}°C",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _infoRow(label: "Humidity", value: "$humidity%"),
                  _infoRow(
                    label: "Wind",
                    value: "${wind_speed.toStringAsFixed(1)} m/s",
                  ),
                  _infoRow(
                    label: "Visibility",
                    value: "${(visibility / 1000).toStringAsFixed(1)} km",
                  ),
                  const SizedBox(height: 40),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      padding: const EdgeInsets.all(24),

                      width: double.infinity,
                      color: Color(0xFF343434),
                      child: Column(
                        children: [
                          Text(
                            summary,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
