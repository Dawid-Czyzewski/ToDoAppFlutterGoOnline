import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:permission_handler/permission_handler.dart';
import 'package:to_do_app/screens/home_screen.dart';
import '../models/task.dart';
import '../main.dart';
import 'notification_config.dart';

@pragma('vm:entry-point')
void onNotificationTap(NotificationResponse response) {
  navigatorKey.currentState?.pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => const HomeScreen()),
    (route) => false,
  );
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Warsaw'));

    if (Platform.isAndroid) {
      final status = await Permission.notification.status;
      if (status.isDenied) {
        final result = await Permission.notification.request();
        if (!result.isGranted) return;
      }
    }

    final exactGranted = await _requestExactAlarmPermission();
    if (!exactGranted) return;

    await _plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
    );
  }

  static Future<bool> _requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.scheduleExactAlarm.status;
      if (status.isDenied) {
        final result = await Permission.scheduleExactAlarm.request();
        return result.isGranted;
      }
    }
    return true;
  }

  static Future<void> scheduleTaskNotification(Task task) async {
    if (task.id == null || task.deadline == null) return;

    final exactGranted = await _requestExactAlarmPermission();
    if (!exactGranted) return;

    final now = DateTime.now();
    final scheduledAt = task.deadline!.subtract(const Duration(hours: 1));
    final notifyTime = scheduledAt.isAfter(now)
        ? scheduledAt
        : (task.deadline!.isAfter(now) ? task.deadline! : now.add(const Duration(seconds: 1)));

    final tzTime = tz.TZDateTime.from(notifyTime, tz.local);

    await _plugin.zonedSchedule(
      task.id!,
      'Przypomnienie',
      'Została godzina do wykonania zadania: ${task.title}',
      tzTime,
      defaultNotificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: task.id.toString(),
    );
  }

  static Future<void> cancelTaskNotification(int id) async {
    await _plugin.cancel(id);
  }
}
