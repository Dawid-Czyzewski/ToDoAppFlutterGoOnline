import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_keys.dart';

class WeatherService {
  static Future<Position> getPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Brak uprawnień do lokalizacji');
      }
    }

    final locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    return Geolocator.getCurrentPosition(locationSettings: locationSettings);
  }

  static Future<Map<String, dynamic>> fetchWeather(Position pos) async {
    final apiKey = ApiKeys.weatherApiKey;
    final url =
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=${pos.latitude},${pos.longitude}&lang=pl';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['current'] as Map<String, dynamic>;
    } else {
      throw Exception('Błąd pobierania pogody: ${response.statusCode}');
    }
  }
}