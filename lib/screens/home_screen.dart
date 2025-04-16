import 'package:flutter/material.dart';
import '../services/weather_services.dart';
import '../models/saved_location.dart';
import '../services/location_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  String _weatherInfo = "Enter a city to get the weather 🌍";

  void _getWeather() async {
    final city = _controller.text.trim();
    if (city.isEmpty) return;

    try {
      final data = await _weatherService.fetchWeather(city);
      setState(() {
        _weatherInfo =
            "${data['weather'][0]['description']} • ${data['main']['temp']}°C";
      });
    } catch (e) {
      setState(() {
        _weatherInfo = "Something went wrong ❌";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NovaWeather")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _getWeather,
              child: const Text("Get Weather"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final message = await _weatherService.pingServer();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Server says: $message")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Ping failed 🚫")));
                }
              },
              child: const Text("Ping Server"),
            ),

            const SizedBox(height: 20),
            Text(
              _weatherInfo,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
