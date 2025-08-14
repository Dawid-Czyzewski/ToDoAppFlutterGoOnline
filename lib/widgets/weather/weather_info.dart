import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  final String iconUrl;
  final String temp;
  final String desc;

  const WeatherInfo(this.iconUrl, this.temp, this.desc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (iconUrl.isNotEmpty)
          Image.network(iconUrl, width: 48, height: 48),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(temp, style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
            Text(desc, style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            )),
          ],
        ),
      ],
    );
  }
}