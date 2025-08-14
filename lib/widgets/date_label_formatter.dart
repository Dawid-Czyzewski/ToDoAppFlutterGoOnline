import 'package:intl/intl.dart';

extension DateLabel on DateTime {
  String get label {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    if (this == today) return 'Dzisiaj';
    if (this == tomorrow) return 'Jutro';
    if (year == now.year) {
      return DateFormat('d MMMM', 'pl').format(this);
    }
    return DateFormat('yyyy-MM-dd').format(this);
  }
}