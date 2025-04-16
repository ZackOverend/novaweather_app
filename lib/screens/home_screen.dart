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
  final LocationStorage _storage = LocationStorage();
  List<SavedLocation> _locations = [];

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
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    final loaded = await _storage.loadLocations();
    setState(() {
      _locations = loaded;
    });
  }

  void _addLocation(String cityName) {
    if (cityName.trim().isEmpty) return;

    final newLocation = SavedLocation(
      city: cityName.trim(),
      country: "Unknown",
    );

    setState(() {
      _locations.add(newLocation);
      _controller.clear();
    });

    _storage.saveLocations(_locations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Locations")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child:
                  _locations.isEmpty
                      ? const Center(child: Text("No saved locations."))
                      : ListView.builder(
                        itemCount: _locations.length,
                        itemBuilder: (context, index) {
                          final loc = _locations[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              title: Text(
                                loc.city,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              ),
                            ),
                          );
                        },
                      ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Enter a city...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _addLocation(_controller.text),
                  child: const Text("Add"),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text("NovaWeather")),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           TextField(
  //             controller: _controller,
  //             decoration: const InputDecoration(
  //               labelText: 'City',
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //           const SizedBox(height: 10),
  //           ElevatedButton(
  //             onPressed: _getWeather,
  //             child: const Text("Get Weather"),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               try {
  //                 final message = await _weatherService.pingServer();
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(content: Text("Server says: $message")),
  //                 );
  //               } catch (e) {
  //                 ScaffoldMessenger.of(
  //                   context,
  //                 ).showSnackBar(SnackBar(content: Text("Ping failed 🚫")));
  //               }
  //             },
  //             child: const Text("Ping Server"),
  //           ),

  //           const SizedBox(height: 20),
  //           Text(
  //             _weatherInfo,
  //             style: const TextStyle(fontSize: 18),
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
