import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const NovaWeatherApp());
}

class NovaWeatherApp extends StatelessWidget {
  const NovaWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NovaWeather',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
