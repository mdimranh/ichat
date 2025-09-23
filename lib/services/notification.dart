// lib/services/notification_service.dart

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService._internal(this.flutterLocalNotificationsPlugin);

  static final NotificationService _instance = NotificationService._internal(
    FlutterLocalNotificationsPlugin(),
  );

  factory NotificationService() => _instance;

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String channelId = 'default_channel',
    String channelName = 'Default Channel',
    String? channelDescription,
    Importance importance = Importance.defaultImportance,
    Priority priority = Priority.defaultPriority,
    bool playSound = true,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
      playSound: playSound,
    );

    final iosDetails = const DarwinNotificationDetails();

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }
}
