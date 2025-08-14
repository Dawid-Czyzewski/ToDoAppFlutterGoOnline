import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
  'tasks_channel',
  'Zadania',
  channelDescription: 'Powiadomienia o zadaniach',
  importance: Importance.max,
  priority: Priority.high,
  playSound: true,
  enableVibration: true,
);

const DarwinNotificationDetails iosNotificationDetails =
    DarwinNotificationDetails();

const NotificationDetails defaultNotificationDetails = NotificationDetails(
  android: androidDetails,
  iOS: iosNotificationDetails,
);

const InitializationSettings initializationSettings = InitializationSettings(
  android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  iOS: DarwinInitializationSettings(),
);
