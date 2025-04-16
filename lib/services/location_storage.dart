import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/saved_location.dart';

class LocationStorage {
  static const String _key = "saved_locations";

  Future<void> saveLocations(List<SavedLocation> locations) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = locations.map((loc) => jsonEncode(loc.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  Future<List<SavedLocation>> loadLocations() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];
    return jsonList.map((item) {
      final map = jsonDecode(item);
      return SavedLocation.fromJson(map);
    }).toList();
  }

  Future<void> clearLocations() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
