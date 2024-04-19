/*
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const _initializationSettingsAndroid =
    AndroidInitializationSettings('ic_launcher');

const _initializationSettingsDarwin = DarwinInitializationSettings();

const _initializationSettings = InitializationSettings(
  android: _initializationSettingsAndroid,
  iOS: _initializationSettingsDarwin,
);

const _androidNotificationDetails = AndroidNotificationDetails(
  'local_notifications_channel',
  'local_notifications_channel',
  channelDescription: 'Local Notification Channel',
  importance: Importance.max,
  priority: Priority.high,
);

const _notificationDetails = NotificationDetails(
  android: _androidNotificationDetails,
);

class LocalNotificationsService {
  LocalNotificationsService._internal();

  static final LocalNotificationsService _instance =
      LocalNotificationsService._internal();

  static LocalNotificationsService get instance => _instance;

  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void init() async {
    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings);
  }

  void showNotification({
    required String title,
    required String body,
  }) async {
    try {
      await FlutterLocalNotificationsPlugin().show(
        math.Random().nextInt(100),
        title,
        body,
        _notificationDetails,
      );
    } catch (error) {
      log(error.toString());
    }
  }
}
*/
