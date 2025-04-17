import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String baseUrl =
      'https://nova-weather-bbewcuf4arhxapc4.canadacentral-01.azurewebsites.net';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse('$baseUrl/weather');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'city': city}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch weather: ${response.statusCode}');
    }
  }

  Future<String> pingServer() async {
    final url = Uri.parse('$baseUrl/');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Ping failed: ${response.statusCode}');
    }
  }
}
