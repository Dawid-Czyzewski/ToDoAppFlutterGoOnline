import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/weather/weather_info.dart';
import 'package:to_do_app/widgets/weather/weather_loading.dart';
import '../../../services/weather_service.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  bool _loading = true;
  String _temp = '';
  String _desc = '';
  String _iconUrl = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final pos = await WeatherService.getPosition();
      final data = await WeatherService.fetchWeather(pos);

      setState(() {
        _temp = '${data['temp_c']}°C';
        _desc = data['condition']['text'];
        _iconUrl = 'https:${data['condition']['icon']}';
        _loading = false;
      });
    } catch (_) {
      setState(() {
        _desc = 'Błąd ładowania pogody';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.3 * 255).round()), // Poprawka
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child:
          _loading ? const WeatherLoading() : WeatherInfo(_iconUrl, _temp, _desc),
    );
  }
}